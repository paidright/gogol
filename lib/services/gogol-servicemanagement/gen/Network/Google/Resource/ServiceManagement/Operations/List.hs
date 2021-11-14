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
-- Module      : Network.Google.Resource.ServiceManagement.Operations.List
-- Copyright   : (c) 2015-2021 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Lists service operations that match the specified filter in the request.
--
-- /See:/ <https://cloud.google.com/service-management/ Service Management API Reference> for @servicemanagement.operations.list@.
module Network.Google.Resource.ServiceManagement.Operations.List
    (
    -- * REST Resource
      OperationsListResource

    -- * Creating a Request
    , operationsList
    , OperationsList

    -- * Request Lenses
    , olXgafv
    , olUploadProtocol
    , olAccessToken
    , olUploadType
    , olName
    , olFilter
    , olPageToken
    , olPageSize
    , olCallback
    ) where

import Network.Google.Prelude
import Network.Google.ServiceManagement.Types

-- | A resource alias for @servicemanagement.operations.list@ method which the
-- 'OperationsList' request conforms to.
type OperationsListResource =
     "v1" :>
       "operations" :>
         QueryParam "$.xgafv" Xgafv :>
           QueryParam "upload_protocol" Text :>
             QueryParam "access_token" Text :>
               QueryParam "uploadType" Text :>
                 QueryParam "name" Text :>
                   QueryParam "filter" Text :>
                     QueryParam "pageToken" Text :>
                       QueryParam "pageSize" (Textual Int32) :>
                         QueryParam "callback" Text :>
                           QueryParam "alt" AltJSON :>
                             Get '[JSON] ListOperationsResponse

-- | Lists service operations that match the specified filter in the request.
--
-- /See:/ 'operationsList' smart constructor.
data OperationsList =
  OperationsList'
    { _olXgafv :: !(Maybe Xgafv)
    , _olUploadProtocol :: !(Maybe Text)
    , _olAccessToken :: !(Maybe Text)
    , _olUploadType :: !(Maybe Text)
    , _olName :: !(Maybe Text)
    , _olFilter :: !(Maybe Text)
    , _olPageToken :: !(Maybe Text)
    , _olPageSize :: !(Maybe (Textual Int32))
    , _olCallback :: !(Maybe Text)
    }
  deriving (Eq, Show, Data, Typeable, Generic)


-- | Creates a value of 'OperationsList' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'olXgafv'
--
-- * 'olUploadProtocol'
--
-- * 'olAccessToken'
--
-- * 'olUploadType'
--
-- * 'olName'
--
-- * 'olFilter'
--
-- * 'olPageToken'
--
-- * 'olPageSize'
--
-- * 'olCallback'
operationsList
    :: OperationsList
operationsList =
  OperationsList'
    { _olXgafv = Nothing
    , _olUploadProtocol = Nothing
    , _olAccessToken = Nothing
    , _olUploadType = Nothing
    , _olName = Nothing
    , _olFilter = Nothing
    , _olPageToken = Nothing
    , _olPageSize = Nothing
    , _olCallback = Nothing
    }


-- | V1 error format.
olXgafv :: Lens' OperationsList (Maybe Xgafv)
olXgafv = lens _olXgafv (\ s a -> s{_olXgafv = a})

-- | Upload protocol for media (e.g. \"raw\", \"multipart\").
olUploadProtocol :: Lens' OperationsList (Maybe Text)
olUploadProtocol
  = lens _olUploadProtocol
      (\ s a -> s{_olUploadProtocol = a})

-- | OAuth access token.
olAccessToken :: Lens' OperationsList (Maybe Text)
olAccessToken
  = lens _olAccessToken
      (\ s a -> s{_olAccessToken = a})

-- | Legacy upload protocol for media (e.g. \"media\", \"multipart\").
olUploadType :: Lens' OperationsList (Maybe Text)
olUploadType
  = lens _olUploadType (\ s a -> s{_olUploadType = a})

-- | Not used.
olName :: Lens' OperationsList (Maybe Text)
olName = lens _olName (\ s a -> s{_olName = a})

-- | A string for filtering Operations. The following filter fields are
-- supported: * serviceName: Required. Only \`=\` operator is allowed. *
-- startTime: The time this job was started, in ISO 8601 format. Allowed
-- operators are \`>=\`, \`>\`, \`\<=\`, and \`\<\`. * status: Can be
-- \`done\`, \`in_progress\`, or \`failed\`. Allowed operators are \`=\`,
-- and \`!=\`. Filter expression supports conjunction (AND) and disjunction
-- (OR) logical operators. However, the serviceName restriction must be at
-- the top-level and can only be combined with other restrictions via the
-- AND logical operator. Examples: *
-- \`serviceName={some-service}.googleapis.com\` *
-- \`serviceName={some-service}.googleapis.com AND
-- startTime>=\"2017-02-01\"\` *
-- \`serviceName={some-service}.googleapis.com AND status=done\` *
-- \`serviceName={some-service}.googleapis.com AND (status=done OR
-- startTime>=\"2017-02-01\")\`
olFilter :: Lens' OperationsList (Maybe Text)
olFilter = lens _olFilter (\ s a -> s{_olFilter = a})

-- | The standard list page token.
olPageToken :: Lens' OperationsList (Maybe Text)
olPageToken
  = lens _olPageToken (\ s a -> s{_olPageToken = a})

-- | The maximum number of operations to return. If unspecified, defaults to
-- 50. The maximum value is 100.
olPageSize :: Lens' OperationsList (Maybe Int32)
olPageSize
  = lens _olPageSize (\ s a -> s{_olPageSize = a}) .
      mapping _Coerce

-- | JSONP
olCallback :: Lens' OperationsList (Maybe Text)
olCallback
  = lens _olCallback (\ s a -> s{_olCallback = a})

instance GoogleRequest OperationsList where
        type Rs OperationsList = ListOperationsResponse
        type Scopes OperationsList =
             '["https://www.googleapis.com/auth/cloud-platform",
               "https://www.googleapis.com/auth/service.management"]
        requestClient OperationsList'{..}
          = go _olXgafv _olUploadProtocol _olAccessToken
              _olUploadType
              _olName
              _olFilter
              _olPageToken
              _olPageSize
              _olCallback
              (Just AltJSON)
              serviceManagementService
          where go
                  = buildClient (Proxy :: Proxy OperationsListResource)
                      mempty
