{-# LANGUAGE OverloadedStrings #-}

module Data.Digest.SRI.Lucid where

import Data.Text
import Data.Text.Encoding
import Data.Digest.SRI
import Lucid
import Lucid.Base

--staticFile :: Text -> FilePath -> Html ()
staticFile url x = term "script" params "" :: Html ()
  where
    params =
      [ src_ url
      , makeAttribute "integrity" (decodeUtf8 (sriHashStrict x))
      , makeAttribute "crossorigin" "anonymous"
      ]

