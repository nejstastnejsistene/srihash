# srihash

Haskell library to generate subresource integrity hashes.
See https://srihash.org/ for more information.

```haskell
{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Lazy.Char8 as LBS

import Data.Digest.SRI
import Data.Digest.SRI.Lucid

main :: IO ()
main = do
  contents <- LBS.readFile "srihash.cabal"
  LBS.putStrLn (sriHash contents)
  print (staticFile "//example.com/srihash.cabal" contents)
```
```
sha512-fzSVEy4qV7cz9AeoVDAaZPgM4DyGkUDO+405RlgQbs805glBI4ojnLU3b7LgcTho12N8UL5RSRedaN5WnC64aA==
<script crossorigin="anonymous" integrity="sha512-fzSVEy4qV7cz9AeoVDAaZPgM4DyGkUDO+405RlgQbs805glBI4ojnLU3b7LgcTho12N8UL5RSRedaN5WnC64aA==" src="//example.com/srihash.html"></script>
```
