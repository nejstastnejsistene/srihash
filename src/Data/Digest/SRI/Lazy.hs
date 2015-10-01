{-# LANGUAGE OverloadedStrings #-}

module Data.Digest.SRI.Lazy
  ( sriHash
  , sriHash256
  , sriHash384
  , sriHash512
  , sriHashFile
  , sriHash256File
  , sriHash384File
  , sriHash512File
  ) where

import qualified Data.ByteString.Lazy.Char8 as LBS
import qualified Data.ByteString.Base64.Lazy as LBS64
import Data.Digest.Pure.SHA
import Data.Monoid

data Algorithm = Sha256 | Sha384 | Sha512

computeHash :: Algorithm -> LBS.ByteString -> LBS.ByteString
computeHash algo = (prefix <>) . LBS64.encode . hash
  where
    (prefix, hash) = case algo of
      Sha256 -> ("sha256-", bytestringDigest . sha256)
      Sha384 -> ("sha384-", bytestringDigest . sha384)
      Sha512 -> ("sha512-", bytestringDigest . sha512)



sriHash :: LBS.ByteString -> LBS.ByteString
sriHash = sriHash512

sriHash256 :: LBS.ByteString -> LBS.ByteString
sriHash256 = computeHash Sha256

sriHash384 :: LBS.ByteString -> LBS.ByteString
sriHash384 = computeHash Sha384

sriHash512 :: LBS.ByteString -> LBS.ByteString
sriHash512 = computeHash Sha512

sriHashFile :: FilePath -> IO LBS.ByteString
sriHashFile f = sriHash <$> LBS.readFile f

sriHash256File :: FilePath -> IO LBS.ByteString
sriHash256File f = sriHash256 <$> LBS.readFile f

sriHash384File :: FilePath -> IO LBS.ByteString
sriHash384File f = sriHash384 <$> LBS.readFile f

sriHash512File :: FilePath -> IO LBS.ByteString
sriHash512File f = sriHash512 <$> LBS.readFile f

main :: IO ()
main = LBS.putStrLn =<< sriHashFile "jquery.min.js"
