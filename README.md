# Purescript Vanilla Web

Medium-level bindings to browser DOM APIs. Under construction.

The main difference between this and `purescript-web-dom` is that `vanilla-web`
uses typeclasses instead of concrete types, and that I write documentation for
functions.

## Getting documentation

This library is currently not in a package set, so you need to build the docs
yourself. First please see the [Building
instructions](./README.md#Building-for-development) and build the library. Then
you can generate the docs with with purescript compiler:
`npx purs docs --format html src/**/*.purs .spago/**/src/**/*.purs`
Next you can open and browse the docs in your favourite browser:
`firefox ./generated-docs/html/Browser.WebRequest.html`
There will be a lot of unrelated library documentation there, that's purescript
current limitation. Fortunately the modules you are interested in start with
Vanilla and so are at the bottom.

## Installation

This library is currently not stable or complete enough to be in a package set,
so you need to add it manually. There are two ways to do that:

1. Using a git submodule:
  ```sh
  git submodule add https://github.com/d86leader/purescript-vanilla-web.git ./libs/vanilla-web
  ```
  Then modify your `packages.dhall` with additions:
  ```dhall
  let additions =
    { vanilla-web = ./libs/vanilla-web/spago.dhall as Location
    }
  ```
  And add `vanilla-web` to your `spago.dhall` as dependencies.

  Also as the library is very much incomplete, you would probably want to fork
  it yourself and add your own repo as a submodule. Don't forget to merge
  request later!

2. Adding as an extra-dep. Modify your packages.dhall with additions:
  ```dhall
    let additions =
      { vanilla-web =
          { dependencies =
            [ "prelude"
            , "effect"
            , "functions"
            , "maybe"
            , "partial"
            ]
          , repo =
              "https://github.com/d86leader/purescript-vanilla-web.git"
          , version =
              "master"
          }
      }
  ```
  You should replace `master` with the latest commit to ensure stability.
  And then add `vanilla-web` to your `spago.dhall` as dependencies.

## Examples

Mozilla example extensions rewritten in purescript:
1. [Your first extension](https://gist.github.com/d86leader/02ac0f5e0f8fa07791c22421d297d9b9)
2. [Your second extension](https://github.com/d86leader/purescript-webext-example2)

## Building for development

Using npm:
- `make` to install dependencies and build the library
- If you prefer to do it by hand, use the commands in the makefile:
  * `npm install` to install PureScript and Spago
  * `npx spago build` to build the library

