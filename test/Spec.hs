{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Lazy.Char8 as LBS

import Data.Digest.SRI
import Data.Digest.SRI.Lucid

main :: IO ()
main = do
  contents <- LBS.readFile "srihash.cabal"
  LBS.putStrLn (sriHash contents)
  print (staticFile "//example.com/srihash.cabal" contents)
