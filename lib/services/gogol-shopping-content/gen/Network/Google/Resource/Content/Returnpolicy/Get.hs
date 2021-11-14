{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE FlexibleInstances  #-}
{-# LANGUAGE NoImplicitPrelude  #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}
{-# LANGUAGE TypeOperators      #-}

{-# OPTIONS_GHC -fno-warn-duplicate-exports #-}
{-# OPTIONS_GHC -fno-warn-unused-binds      #-}
{-# OPTIONS_GHC -fno-warn-unused-imports    #-}

-- |
-- Module      : Network.Google.Resource.Content.Returnpolicy.Get
-- Copyright   : (c) 2015-2021 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Gets a return policy of the Merchant Center account.
--
-- /See:/ <https://developers.google.com/shopping-content/v2/ Content API for Shopping Reference> for @content.returnpolicy.get@.
module Network.Google.Resource.Content.Returnpolicy.Get
    (
    -- * REST Resource
      ReturnpolicyGetResource

    -- * Creating a Request
    , returnpolicyGet
    , ReturnpolicyGet

    -- * Request Lenses
    , rgXgafv
    , rgReturnPolicyId
    , rgMerchantId
    , rgUploadProtocol
    , rgAccessToken
    , rgUploadType
    , rgCallback
    ) where

import Network.Google.Prelude
import Network.Google.ShoppingContent.Types

-- | A resource alias for @content.returnpolicy.get@ method which the
-- 'ReturnpolicyGet' request conforms to.
type ReturnpolicyGetResource =
     "content" :>
       "v2.1" :>
         Capture "merchantId" (Textual Word64) :>
           "returnpolicy" :>
             Capture "returnPolicyId" Text :>
               QueryParam "$.xgafv" Xgafv :>
                 QueryParam "upload_protocol" Text :>
                   QueryParam "access_token" Text :>
                     QueryParam "uploadType" Text :>
                       QueryParam "callback" Text :>
                         QueryParam "alt" AltJSON :> Get '[JSON] ReturnPolicy

-- | Gets a return policy of the Merchant Center account.
--
-- /See:/ 'returnpolicyGet' smart constructor.
data ReturnpolicyGet =
  ReturnpolicyGet'
    { _rgXgafv :: !(Maybe Xgafv)
    , _rgReturnPolicyId :: !Text
    , _rgMerchantId :: !(Textual Word64)
    , _rgUploadProtocol :: !(Maybe Text)
    , _rgAccessToken :: !(Maybe Text)
    , _rgUploadType :: !(Maybe Text)
    , _rgCallback :: !(Maybe Text)
    }
  deriving (Eq, Show, Data, Typeable, Generic)


-- | Creates a value of 'ReturnpolicyGet' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'rgXgafv'
--
-- * 'rgReturnPolicyId'
--
-- * 'rgMerchantId'
--
-- * 'rgUploadProtocol'
--
-- * 'rgAccessToken'
--
-- * 'rgUploadType'
--
-- * 'rgCallback'
returnpolicyGet
    :: Text -- ^ 'rgReturnPolicyId'
    -> Word64 -- ^ 'rgMerchantId'
    -> ReturnpolicyGet
returnpolicyGet pRgReturnPolicyId_ pRgMerchantId_ =
  ReturnpolicyGet'
    { _rgXgafv = Nothing
    , _rgReturnPolicyId = pRgReturnPolicyId_
    , _rgMerchantId = _Coerce # pRgMerchantId_
    , _rgUploadProtocol = Nothing
    , _rgAccessToken = Nothing
    , _rgUploadType = Nothing
    , _rgCallback = Nothing
    }


-- | V1 error format.
rgXgafv :: Lens' ReturnpolicyGet (Maybe Xgafv)
rgXgafv = lens _rgXgafv (\ s a -> s{_rgXgafv = a})

-- | Return policy ID generated by Google.
rgReturnPolicyId :: Lens' ReturnpolicyGet Text
rgReturnPolicyId
  = lens _rgReturnPolicyId
      (\ s a -> s{_rgReturnPolicyId = a})

-- | The Merchant Center account to get a return policy for.
rgMerchantId :: Lens' ReturnpolicyGet Word64
rgMerchantId
  = lens _rgMerchantId (\ s a -> s{_rgMerchantId = a})
      . _Coerce

-- | Upload protocol for media (e.g. \"raw\", \"multipart\").
rgUploadProtocol :: Lens' ReturnpolicyGet (Maybe Text)
rgUploadProtocol
  = lens _rgUploadProtocol
      (\ s a -> s{_rgUploadProtocol = a})

-- | OAuth access token.
rgAccessToken :: Lens' ReturnpolicyGet (Maybe Text)
rgAccessToken
  = lens _rgAccessToken
      (\ s a -> s{_rgAccessToken = a})

-- | Legacy upload protocol for media (e.g. \"media\", \"multipart\").
rgUploadType :: Lens' ReturnpolicyGet (Maybe Text)
rgUploadType
  = lens _rgUploadType (\ s a -> s{_rgUploadType = a})

-- | JSONP
rgCallback :: Lens' ReturnpolicyGet (Maybe Text)
rgCallback
  = lens _rgCallback (\ s a -> s{_rgCallback = a})

instance GoogleRequest ReturnpolicyGet where
        type Rs ReturnpolicyGet = ReturnPolicy
        type Scopes ReturnpolicyGet =
             '["https://www.googleapis.com/auth/content"]
        requestClient ReturnpolicyGet'{..}
          = go _rgMerchantId _rgReturnPolicyId _rgXgafv
              _rgUploadProtocol
              _rgAccessToken
              _rgUploadType
              _rgCallback
              (Just AltJSON)
              shoppingContentService
          where go
                  = buildClient
                      (Proxy :: Proxy ReturnpolicyGetResource)
                      mempty
