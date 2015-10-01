import Data.ByteString.Lazy.Char8 (unpack)
import Data.Digest.SRI.Lazy

main :: IO ()
main = do
  integrity <- sriHash256File "srihash.cabal"
  putStrLn (unpack integrity)
