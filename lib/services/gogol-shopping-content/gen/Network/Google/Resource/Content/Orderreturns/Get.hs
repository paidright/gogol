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
-- Module      : Network.Google.Resource.Content.Orderreturns.Get
-- Copyright   : (c) 2015-2021 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Retrieves an order return from your Merchant Center account.
--
-- /See:/ <https://developers.google.com/shopping-content/v2/ Content API for Shopping Reference> for @content.orderreturns.get@.
module Network.Google.Resource.Content.Orderreturns.Get
    (
    -- * REST Resource
      OrderreturnsGetResource

    -- * Creating a Request
    , orderreturnsGet
    , OrderreturnsGet

    -- * Request Lenses
    , oggXgafv
    , oggMerchantId
    , oggUploadProtocol
    , oggAccessToken
    , oggUploadType
    , oggReturnId
    , oggCallback
    ) where

import Network.Google.Prelude
import Network.Google.ShoppingContent.Types

-- | A resource alias for @content.orderreturns.get@ method which the
-- 'OrderreturnsGet' request conforms to.
type OrderreturnsGetResource =
     "content" :>
       "v2.1" :>
         Capture "merchantId" (Textual Word64) :>
           "orderreturns" :>
             Capture "returnId" Text :>
               QueryParam "$.xgafv" Xgafv :>
                 QueryParam "upload_protocol" Text :>
                   QueryParam "access_token" Text :>
                     QueryParam "uploadType" Text :>
                       QueryParam "callback" Text :>
                         QueryParam "alt" AltJSON :>
                           Get '[JSON] MerchantOrderReturn

-- | Retrieves an order return from your Merchant Center account.
--
-- /See:/ 'orderreturnsGet' smart constructor.
data OrderreturnsGet =
  OrderreturnsGet'
    { _oggXgafv :: !(Maybe Xgafv)
    , _oggMerchantId :: !(Textual Word64)
    , _oggUploadProtocol :: !(Maybe Text)
    , _oggAccessToken :: !(Maybe Text)
    , _oggUploadType :: !(Maybe Text)
    , _oggReturnId :: !Text
    , _oggCallback :: !(Maybe Text)
    }
  deriving (Eq, Show, Data, Typeable, Generic)


-- | Creates a value of 'OrderreturnsGet' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'oggXgafv'
--
-- * 'oggMerchantId'
--
-- * 'oggUploadProtocol'
--
-- * 'oggAccessToken'
--
-- * 'oggUploadType'
--
-- * 'oggReturnId'
--
-- * 'oggCallback'
orderreturnsGet
    :: Word64 -- ^ 'oggMerchantId'
    -> Text -- ^ 'oggReturnId'
    -> OrderreturnsGet
orderreturnsGet pOggMerchantId_ pOggReturnId_ =
  OrderreturnsGet'
    { _oggXgafv = Nothing
    , _oggMerchantId = _Coerce # pOggMerchantId_
    , _oggUploadProtocol = Nothing
    , _oggAccessToken = Nothing
    , _oggUploadType = Nothing
    , _oggReturnId = pOggReturnId_
    , _oggCallback = Nothing
    }


-- | V1 error format.
oggXgafv :: Lens' OrderreturnsGet (Maybe Xgafv)
oggXgafv = lens _oggXgafv (\ s a -> s{_oggXgafv = a})

-- | The ID of the account that manages the order. This cannot be a
-- multi-client account.
oggMerchantId :: Lens' OrderreturnsGet Word64
oggMerchantId
  = lens _oggMerchantId
      (\ s a -> s{_oggMerchantId = a})
      . _Coerce

-- | Upload protocol for media (e.g. \"raw\", \"multipart\").
oggUploadProtocol :: Lens' OrderreturnsGet (Maybe Text)
oggUploadProtocol
  = lens _oggUploadProtocol
      (\ s a -> s{_oggUploadProtocol = a})

-- | OAuth access token.
oggAccessToken :: Lens' OrderreturnsGet (Maybe Text)
oggAccessToken
  = lens _oggAccessToken
      (\ s a -> s{_oggAccessToken = a})

-- | Legacy upload protocol for media (e.g. \"media\", \"multipart\").
oggUploadType :: Lens' OrderreturnsGet (Maybe Text)
oggUploadType
  = lens _oggUploadType
      (\ s a -> s{_oggUploadType = a})

-- | Merchant order return ID generated by Google.
oggReturnId :: Lens' OrderreturnsGet Text
oggReturnId
  = lens _oggReturnId (\ s a -> s{_oggReturnId = a})

-- | JSONP
oggCallback :: Lens' OrderreturnsGet (Maybe Text)
oggCallback
  = lens _oggCallback (\ s a -> s{_oggCallback = a})

instance GoogleRequest OrderreturnsGet where
        type Rs OrderreturnsGet = MerchantOrderReturn
        type Scopes OrderreturnsGet =
             '["https://www.googleapis.com/auth/content"]
        requestClient OrderreturnsGet'{..}
          = go _oggMerchantId _oggReturnId _oggXgafv
              _oggUploadProtocol
              _oggAccessToken
              _oggUploadType
              _oggCallback
              (Just AltJSON)
              shoppingContentService
          where go
                  = buildClient
                      (Proxy :: Proxy OrderreturnsGetResource)
                      mempty
