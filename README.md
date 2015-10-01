# srihash

Haskell library to generate subresource integrity hashes.
See https://srihash.org/ for more information.

```haskell
import Data.ByteString.Lazy.Char8 (unpack)
import Data.Digest.SRI.Lazy

main :: IO ()
main = do
  integrity <- sriHash256File "srihash.cabal"
  putStrLn (unpack integrity)
  -- prints: sha256-rYbF2TpcvFnXJ5G/zHJPCETHpTHAfXqfE+fhoEzYSIw=
```
