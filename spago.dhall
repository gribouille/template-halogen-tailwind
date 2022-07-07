{ name = "template-halogen-tailwind"
, sources = [ "src/**/*.purs" ]
, packages =
    https://github.com/purescript/package-sets/releases/download/psc-0.15.2-20220620/packages.dhall
      sha256:75dbb7030870982349c4eed33b2459aa8325ceb4f727e277495c87e8e0a1d788
, dependencies =
  [ "aff"
  , "affjax"
  , "affjax-web"
  , "argonaut"
  , "argonaut-codecs"
  , "console"
  , "datetime"
  , "debug"
  , "effect"
  , "either"
  , "enums"
  , "halogen"
  , "halogen-store"
  , "integers"
  , "maybe"
  , "prelude"
  , "routing"
  , "routing-duplex"
  , "safe-coerce"
  , "transformers"
  , "unsafe-coerce"
  ]
}
