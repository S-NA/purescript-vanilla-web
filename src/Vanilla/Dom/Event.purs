{-
    | Event type, EventTarget class and methods concerning them. Related entries:
    | - [EventTarget](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget)
    | - [Event](https://developer.mozilla.org/en-US/docs/Web/API/Event)
-}
module Vanilla.Dom.Event
    ( Event, eventTarget
    , class EventTarget, addEventListener, removeEventListener, dispatchEvent
    , AnyEventTarget, class FromEventTarget, fromEventTarget, fromEventTargetEx
    ) where

import Prelude
import Data.Maybe (Maybe, fromJust)
import Effect     (Effect)
import Partial.Unsafe (unsafePartial)
import Effect.Uncurried ( EffectFn3, EffectFn2, EffectFn1
                        , runEffectFn3, runEffectFn2, mkEffectFn1
                        )


-- | Type of js events that we can listen to
foreign import data Event :: Type

-- | Get `target` property of event.
-- | [Event.target](https://developer.mozilla.org/en-US/docs/Web/API/Event/target)
foreign import eventTarget :: Event -> AnyEventTarget


-- | Class of foreign objects that can have events. If your object is an
-- | EventTarget descendant, instantiate this class and use functions below.
class EventTarget et

-- | [addEventListener](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener)
addEventListener :: forall et. EventTarget et
    => String -- ^ Event type (like `click`)
    -> (Event -> Effect Unit) -- ^ Callback
    -> et -- ^ Target
    -> Effect Unit
addEventListener type_ = runEffectFn3 addEventListener_ type_ <<< mkEffectFn1
-- | [removeEventListener](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener)
removeEventListener :: forall et. EventTarget et 
    => String -- ^ Event type (like `click`)
    -> (Event -> Effect Unit) -- ^ Callback
    -> et -- ^ Target
    -> Effect Unit
removeEventListener type_ = runEffectFn3 removeEventListener_ type_ <<< mkEffectFn1
-- | [dispatchEvent](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent)
dispatchEvent :: forall et. EventTarget et
    => Event -- ^ Event to dispatch
    -> et
    -> Effect Boolean
dispatchEvent = runEffectFn2 dispatchEvent_

-- JS implementation of those methods
foreign import addEventListener_ :: forall a.
    EffectFn3 String (EffectFn1 Event Unit) a Unit
foreign import removeEventListener_ :: forall a.
    EffectFn3 String (EffectFn1 Event Unit) a Unit
foreign import dispatchEvent_ :: forall a.
    EffectFn2 Event a Boolean


-- | Polymorphic type for EventTarget return values
foreign import data AnyEventTarget :: Type
instance anyEventTarget :: EventTarget AnyEventTarget

-- | Class to get concrete type of event target. Instances are to be created
-- | with JS.
class FromEventTarget a where
    fromEventTarget :: AnyEventTarget -> Maybe a
-- | Unsafe wrapper
fromEventTargetEx :: forall a. FromEventTarget a => AnyEventTarget -> a
fromEventTargetEx et = unsafePartial $ fromJust $ fromEventTarget et
