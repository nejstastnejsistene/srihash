{-# LANGUAGE OverloadedStrings #-}

module Data.Digest.SRI
  ( sriHash
  , sriHash256
  , sriHash384
  , sriHash512
  , sriHashFile
  , sriHash256File
  , sriHash384File
  , sriHash512File
  , sriHashStrict
  , sriHash256Strict
  , sriHash384Strict
  , sriHash512Strict
  , sriHashFileStrict
  , sriHash256FileStrict
  , sriHash384FileStrict
  , sriHash512FileStrict
  ) where

import qualified Data.ByteString.Base64.Lazy as BS64
import qualified Data.ByteString.Base64.Lazy as LBS64
import qualified Data.ByteString.Char8 as BS
import qualified Data.ByteString.Lazy.Char8 as LBS
import Data.Digest.Pure.SHA
import Data.Monoid

data Algorithm = Sha256 | Sha384 | Sha512

computeHash algo = (prefix <>) . LBS64.encode . hash
  where
    (prefix, hash) = case algo of
      Sha256 -> ("sha256-", bytestringDigest . sha256)
      Sha384 -> ("sha384-", bytestringDigest . sha384)
      Sha512 -> ("sha512-", bytestringDigest . sha512)

sriHash    = sriHash512
sriHash256 = computeHash Sha256
sriHash384 = computeHash Sha384
sriHash512 = computeHash Sha512

sriHashFile f    = sriHash    <$> LBS.readFile f
sriHash256File f = sriHash256 <$> LBS.readFile f
sriHash384File f = sriHash384 <$> LBS.readFile f
sriHash512File f = sriHash512 <$> LBS.readFile f

sriHashStrict    = LBS.toStrict . sriHash
sriHash256Strict = LBS.toStrict . sriHash256
sriHash384Strict = LBS.toStrict . sriHash384
sriHash512Strict = LBS.toStrict . sriHash512

sriHashFileStrict    f = LBS.toStrict <$> sriHashFile f
sriHash256FileStrict f = LBS.toStrict <$> sriHash256File f
sriHash384FileStrict f = LBS.toStrict <$> sriHash384File f
sriHash512FileStrict f = LBS.toStrict <$> sriHash512File f

main :: IO ()
main = LBS.putStrLn =<< sriHashFile "jquery.min.js"
