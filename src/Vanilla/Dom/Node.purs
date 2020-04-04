{-
    | Node class, helper types and their functions. Related entries:
    | - [Node](https://developer.mozilla.org/en-US/docs/Web/API/Node)
-}
module Vanilla.Dom.Node
    ( class Node, textContent, childNodes, appendChild
    , NodeList, nodeListLength, nodeListItem, traverseNodeList
    , AnyNode, class FromNode, fromNode, fromNodeEx
    , class QueryNode, querySelector, querySelectorAll
    ) where

import Prelude
import Data.Maybe (Maybe, fromJust)
import Data.Function.Uncurried (Fn2, Fn3, runFn2, runFn3)
import Effect (Effect)
import Effect.Uncurried (EffectFn2, EffectFn1, runEffectFn2, runEffectFn1)
import Partial.Unsafe (unsafePartial)
import Vanilla.Dom.Event (class EventTarget)


-- | Class of Node foreign objects, like Element and Document If your object is
-- | an EventTarget descendant, instantiate this class and use functions below.
class EventTarget a <= Node a

-- | Text content of node.
-- | [Node.textContent](https://developer.mozilla.org/en-US/docs/Web/API/Node/textContent)
textContent :: forall a. Node a => a -> Effect String
textContent = runEffectFn1 textContent_
foreign import textContent_ :: forall a. EffectFn1 a String
-- | Children of the node. Careful: this object is live and may change on
-- | your hands.
-- | [Node.childNodes](https://developer.mozilla.org/en-US/docs/Web/API/Node/childNodes)
foreign import childNodes :: forall a. a -> Effect NodeList
-- | Add new node to the end of the list of childern. If this node already
-- | exists in a document, instead move it to this new position.
-- | [Node.appendChild](https://developer.mozilla.org/en-US/docs/Web/API/Node/appendChild)
appendChild :: forall a b. Node a => Node b
    => a -- ^ Parent, receiver
    -> b -- ^ Child to append
    -> Effect b -- ^ Appended child
appendChild = runEffectFn2 appendChild_
foreign import appendChild_ :: forall a b. EffectFn2 a b b


-- | Monomorphic mutable container of nodes.
-- | [NodeList](https://developer.mozilla.org/en-US/docs/Web/API/NodeList)
foreign import data NodeList :: Type

-- | Get length in some monad, most probably Effect
nodeListLength :: forall m. Applicative m => NodeList -> m Int
nodeListLength = runFn2 nodeListLength_ pure
foreign import nodeListLength_ :: forall m.
    Fn2 (Int -> m Int) NodeList (m Int)
-- | Throws an exception when index out of bounds
nodeListItem :: forall m. Applicative m => Int -> NodeList -> m AnyNode
nodeListItem = runFn3 nodeListItem_ pure
foreign import nodeListItem_ :: forall m.
    Fn3 (AnyNode -> m AnyNode) Int NodeList (m AnyNode)
-- | Traverse the node list and execute an action, discarding the result
traverseNodeList :: forall m. Applicative m =>
    (AnyNode -> m Unit) -> NodeList -> m Unit
traverseNodeList func list = runFn3 traverseNodeList_ (pure unit) func list
foreign import traverseNodeList_ :: forall m a.
    Fn3 (m Unit) (AnyNode -> m a) NodeList (m Unit)


-- | Polymorphic type for return values
foreign import data AnyNode :: Type
instance eventTargetAnyNode :: EventTarget AnyNode
instance anyNode :: Node AnyNode

-- | Class to get concrete type of Node class. Instances are to be created with
-- | JS.
class FromNode a where
    fromNode :: AnyNode -> Maybe a
-- | Unsafe wrapper
fromNodeEx :: forall a. FromNode a => AnyNode -> a
fromNodeEx et = unsafePartial $ fromJust $ fromNode et


-- | Mixin class; a node which supports querySelector method. Like other
-- | classes here, if your foreign type conforms, you can instantiate this
-- | class for it and use the methods. Examples are Element and Document.
class Node a <= QueryNode a

-- | Query child nodes. Returns first match.
-- | [Element.querySelector](https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelector)
querySelector :: forall a. QueryNode a => String -> a -> AnyNode
querySelector = runFn2 querySelector_
foreign import querySelector_ :: forall a. Fn2 String a AnyNode
-- | Query child nodes. Returns all matches.
-- | [Element.querySelectorAll](https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelectorAll)
querySelectorAll :: forall a. QueryNode a => String -> a -> NodeList
querySelectorAll = runFn2 querySelectorAll_
foreign import querySelectorAll_ :: forall a. Fn2 String a NodeList
