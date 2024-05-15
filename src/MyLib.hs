{-# LANGUAGE OverloadedStrings #-}
module MyLib where

  import Network.Socket

  newtype LocalHost = LocalHost { name :: String }

  host :: Maybe LocalHost
  host = Just LocalHost { name = "localhost" }

  hints :: AddrInfo
  hints = defaultHints { addrFlags = [AI_PASSIVE], addrFamily = AF_UNSPEC, addrSocketType = Stream }

  info ::  IO [AddrInfo]
  info = getAddrInfo (Just hints) (Just "www.google.com") (Just "80")

  getAddrCmd :: [String] -> IO [AddrInfo]
  getAddrCmd [] = return []
  getAddrCmd [ip] = getAddrInfo (Just hints) (Just ip) (Just "80")
  getAddrCmd _ = return []


  -- inet_pton() in C is equivalent to hostAddressToTuple
  -- inet_ntop() is equivalent to tupleToHostAddress