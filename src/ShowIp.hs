{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
module ShowIp (getAddrCmd, getSockAddr, getSocket) where

  import Network.Socket
  import qualified Control.Exception as E
  
  hints :: AddrInfo
  hints = defaultHints { addrFlags = [AI_PASSIVE], addrFamily = AF_UNSPEC, addrSocketType = Stream }
  
  getAddrCmd :: [String] -> IO [AddrInfo]
  getAddrCmd [] = return []
  getAddrCmd [ip] = getAddrInfo (Just hints) (Just ip) (Just "80")
  getAddrCmd _ = return []

  getSockAddr :: AddrInfo -> String
  getSockAddr info =
    "IP Address: " <> show (addrAddress info)

  getSocket :: [String] -> IO Socket
  getSocket ip = withSocketsDo $ do
    info <- getAddrCmd ip
    let ip_address:_ = ip
    putStrLn ("connecting to socket on: " <> ip_address)
    open $ head info
    where
      open info = E.bracketOnError (openSocket info) close $
        \s -> do
          connect s $ addrAddress info
          return s
