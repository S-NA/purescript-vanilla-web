{-
    | Element type and instances
    | [Element](https://developer.mozilla.org/en-US/docs/Web/API/Element)
-}
module Vanilla.Dom.Element
    ( Element
    , innerText, innerHtml, classList
    , setAttribute, getAttribute
    , remove
    , getStyle, setStyle
    , tagName
    ) where

import Data.Maybe (Maybe (Just, Nothing))
import Data.Function.Uncurried (Fn3, runFn3)
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Uncurried (EffectFn3, runEffectFn3, EffectFn2, runEffectFn2)
import Vanilla.Dom.Event (class EventTarget, class FromEventTarget)
import Vanilla.Dom.Node (class Node, class FromNode, class QueryNode)
import Vanilla.Dom.TokenList (TokenList)

import Vanilla.Dom.Event as Ev
import Vanilla.Dom.Node as Nd


-- | Element type, which is HTMLElement or XMLElement
foreign import data Element :: Type

-- | Rendered text of HTMLElement.
-- | [innerText](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/innerText)
foreign import innerText :: Element -> String

-- | Raw text of HTMLElement.
-- | [innerHTML](https://developer.mozilla.org/en-US/docs/Web/API/Element/innerHTML)
foreign import innerHtml :: Element -> String

-- | Class attributes of element
-- | [classList](https://developer.mozilla.org/en-US/docs/Web/API/Element/classList)
foreign import classList :: Element -> TokenList

-- | Set (create or update) an attribute on element
-- | [setAttribute](https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute)
setAttribute :: String -- ^ Attribute name
             -> Element -- ^ Target element
             -> String -- ^ New attribute value
             -> Effect Unit
setAttribute = runEffectFn3 setAttribute_
foreign import setAttribute_ :: EffectFn3 String Element String Unit

-- | Get an attribute on element
-- | [getAttribute](https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttribute)
getAttribute :: String -- ^ Attribute name
             -> Element -- ^ Target element
             -> Effect String
getAttribute = runEffectFn2 getAttribute_
foreign import getAttribute_ :: EffectFn2 String Element String

-- | Remove element from node tree
-- | [remove](https://developer.mozilla.org/en-US/docs/Web/API/ChildNode/remove)
foreign import remove :: Element -> Effect Unit

-- | Get style of element. The docs are all over the place, but you can start
-- | here:
-- | [style](https://developer.mozilla.org/en-US/docs/Web/API/ElementCSSInlineStyle/style)
foreign import getStyle :: String -- ^ Property name
                        -> Element -- ^ Target element
                        -> String

-- | Set style of element. For example, `setStyle "color" elem "blue"`
setStyle :: String -- ^ Property name
         -> Element -- ^ Target element
         -> String -- ^ Property value
         -> Effect Unit
setStyle = runEffectFn3 setStyle_
foreign import setStyle_ :: EffectFn3 String Element String Unit

-- | Element tag name
-- | [tagName](https://developer.mozilla.org/en-US/docs/Web/API/Element/tagName)
foreign import tagName :: Element -> Effect String


instance elemEventTarget :: EventTarget Element

instance elemFromEventTarget :: FromEventTarget Element where
    fromEventTarget = runFn3 fromEventTarget_ Just Nothing
foreign import fromEventTarget_ :: Fn3 (forall a. a -> Maybe a)
                                       (forall a. Maybe a)
                                       Ev.AnyEventTarget
                                       (Maybe Element)

instance elemNode :: Node Element

instance elemFromNode :: FromNode Element where
    fromNode = runFn3 fromNode_ Just Nothing
foreign import fromNode_ :: Fn3 (forall a. a -> Maybe a)
                                (forall a. Maybe a)
                                Nd.AnyNode
                                (Maybe Element)

instance elemQuery :: QueryNode Element
