{-# LANGUAGE OverloadedStrings #-}
module Main where

import System.Environment
import System.Exit
import Network.Socket.ByteString
import qualified Data.ByteString.Char8 as C


import ShowIp (getSocket)

main :: IO ()
main = do
  args <- getArgs
  sock <- getSocket args
  sendAll sock "GET / HTTP/1.1\nHost:www.icanhazip.com\n\n"
  msg <- recv sock 1024
  C.putStrLn msg
  exitSuccess
