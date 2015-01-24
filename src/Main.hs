{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Twitter.Conduit
import Web.Twitter.Types.Lens
import Web.Authenticate.OAuth
import Network.HTTP.Conduit
import Control.Lens
import System.Environment

tokens :: OAuth
tokens =
  twitterOAuth {oauthConsumerKey = ""
               ,oauthConsumerSecret = ""}

credential :: Credential
credential =
  Credential
    [("oauth_token","")
    ,("oauth_token_secret","")]

twitterInfo :: TWInfo
twitterInfo =
  def {twToken =
         def {twOAuth = tokens
             ,twCredential = credential}
      ,twProxy = Nothing}

main :: IO ()
main =
  do [keyword] <- getArgs
     timeline <- withManager fetchTimeline
     mapM_ print $
       fmap select timeline
  where fetchTimeline manager =
          call twitterInfo manager $
          homeTimeline & count ?~ 200
        select tweet =
          (tweet ^. statusUser ^. userScreenName,tweet ^. statusText)
