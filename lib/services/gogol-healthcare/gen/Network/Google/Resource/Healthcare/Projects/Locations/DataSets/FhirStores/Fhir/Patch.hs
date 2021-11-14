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
-- Module      : Network.Google.Resource.Healthcare.Projects.Locations.DataSets.FhirStores.Fhir.Patch
-- Copyright   : (c) 2015-2021 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Updates part of an existing resource by applying the operations
-- specified in a [JSON Patch](http:\/\/jsonpatch.com\/) document.
-- Implements the FHIR standard patch interaction
-- ([STU3](http:\/\/hl7.org\/implement\/standards\/fhir\/STU3\/http.html#patch),
-- [R4](http:\/\/hl7.org\/implement\/standards\/fhir\/R4\/http.html#patch)).
-- DSTU2 doesn\'t define a patch method, but the server supports it in the
-- same way it supports STU3. The request body must contain a JSON Patch
-- document, and the request headers must contain \`Content-Type:
-- application\/json-patch+json\`. On success, the response body contains a
-- JSON-encoded representation of the updated resource, including the
-- server-assigned version ID. Errors generated by the FHIR store contain a
-- JSON-encoded \`OperationOutcome\` resource describing the reason for the
-- error. If the request cannot be mapped to a valid API method on a FHIR
-- store, a generic GCP error might be returned instead. For samples that
-- show how to call \`patch\`, see [Patching a FHIR
-- resource](\/healthcare\/docs\/how-tos\/fhir-resources#patching_a_fhir_resource).
--
-- /See:/ <https://cloud.google.com/healthcare Cloud Healthcare API Reference> for @healthcare.projects.locations.datasets.fhirStores.fhir.patch@.
module Network.Google.Resource.Healthcare.Projects.Locations.DataSets.FhirStores.Fhir.Patch
    (
    -- * REST Resource
      ProjectsLocationsDataSetsFhirStoresFhirPatchResource

    -- * Creating a Request
    , projectsLocationsDataSetsFhirStoresFhirPatch
    , ProjectsLocationsDataSetsFhirStoresFhirPatch

    -- * Request Lenses
    , pldsfsfpXgafv
    , pldsfsfpUploadProtocol
    , pldsfsfpAccessToken
    , pldsfsfpUploadType
    , pldsfsfpPayload
    , pldsfsfpName
    , pldsfsfpCallback
    ) where

import Network.Google.Healthcare.Types
import Network.Google.Prelude

-- | A resource alias for @healthcare.projects.locations.datasets.fhirStores.fhir.patch@ method which the
-- 'ProjectsLocationsDataSetsFhirStoresFhirPatch' request conforms to.
type ProjectsLocationsDataSetsFhirStoresFhirPatchResource
     =
     "v1" :>
       Capture "name" Text :>
         QueryParam "$.xgafv" Xgafv :>
           QueryParam "upload_protocol" Text :>
             QueryParam "access_token" Text :>
               QueryParam "uploadType" Text :>
                 QueryParam "callback" Text :>
                   QueryParam "alt" AltJSON :>
                     ReqBody '[JSON] HTTPBody :> Patch '[JSON] HTTPBody

-- | Updates part of an existing resource by applying the operations
-- specified in a [JSON Patch](http:\/\/jsonpatch.com\/) document.
-- Implements the FHIR standard patch interaction
-- ([STU3](http:\/\/hl7.org\/implement\/standards\/fhir\/STU3\/http.html#patch),
-- [R4](http:\/\/hl7.org\/implement\/standards\/fhir\/R4\/http.html#patch)).
-- DSTU2 doesn\'t define a patch method, but the server supports it in the
-- same way it supports STU3. The request body must contain a JSON Patch
-- document, and the request headers must contain \`Content-Type:
-- application\/json-patch+json\`. On success, the response body contains a
-- JSON-encoded representation of the updated resource, including the
-- server-assigned version ID. Errors generated by the FHIR store contain a
-- JSON-encoded \`OperationOutcome\` resource describing the reason for the
-- error. If the request cannot be mapped to a valid API method on a FHIR
-- store, a generic GCP error might be returned instead. For samples that
-- show how to call \`patch\`, see [Patching a FHIR
-- resource](\/healthcare\/docs\/how-tos\/fhir-resources#patching_a_fhir_resource).
--
-- /See:/ 'projectsLocationsDataSetsFhirStoresFhirPatch' smart constructor.
data ProjectsLocationsDataSetsFhirStoresFhirPatch =
  ProjectsLocationsDataSetsFhirStoresFhirPatch'
    { _pldsfsfpXgafv :: !(Maybe Xgafv)
    , _pldsfsfpUploadProtocol :: !(Maybe Text)
    , _pldsfsfpAccessToken :: !(Maybe Text)
    , _pldsfsfpUploadType :: !(Maybe Text)
    , _pldsfsfpPayload :: !HTTPBody
    , _pldsfsfpName :: !Text
    , _pldsfsfpCallback :: !(Maybe Text)
    }
  deriving (Eq, Show, Data, Typeable, Generic)


-- | Creates a value of 'ProjectsLocationsDataSetsFhirStoresFhirPatch' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'pldsfsfpXgafv'
--
-- * 'pldsfsfpUploadProtocol'
--
-- * 'pldsfsfpAccessToken'
--
-- * 'pldsfsfpUploadType'
--
-- * 'pldsfsfpPayload'
--
-- * 'pldsfsfpName'
--
-- * 'pldsfsfpCallback'
projectsLocationsDataSetsFhirStoresFhirPatch
    :: HTTPBody -- ^ 'pldsfsfpPayload'
    -> Text -- ^ 'pldsfsfpName'
    -> ProjectsLocationsDataSetsFhirStoresFhirPatch
projectsLocationsDataSetsFhirStoresFhirPatch pPldsfsfpPayload_ pPldsfsfpName_ =
  ProjectsLocationsDataSetsFhirStoresFhirPatch'
    { _pldsfsfpXgafv = Nothing
    , _pldsfsfpUploadProtocol = Nothing
    , _pldsfsfpAccessToken = Nothing
    , _pldsfsfpUploadType = Nothing
    , _pldsfsfpPayload = pPldsfsfpPayload_
    , _pldsfsfpName = pPldsfsfpName_
    , _pldsfsfpCallback = Nothing
    }


-- | V1 error format.
pldsfsfpXgafv :: Lens' ProjectsLocationsDataSetsFhirStoresFhirPatch (Maybe Xgafv)
pldsfsfpXgafv
  = lens _pldsfsfpXgafv
      (\ s a -> s{_pldsfsfpXgafv = a})

-- | Upload protocol for media (e.g. \"raw\", \"multipart\").
pldsfsfpUploadProtocol :: Lens' ProjectsLocationsDataSetsFhirStoresFhirPatch (Maybe Text)
pldsfsfpUploadProtocol
  = lens _pldsfsfpUploadProtocol
      (\ s a -> s{_pldsfsfpUploadProtocol = a})

-- | OAuth access token.
pldsfsfpAccessToken :: Lens' ProjectsLocationsDataSetsFhirStoresFhirPatch (Maybe Text)
pldsfsfpAccessToken
  = lens _pldsfsfpAccessToken
      (\ s a -> s{_pldsfsfpAccessToken = a})

-- | Legacy upload protocol for media (e.g. \"media\", \"multipart\").
pldsfsfpUploadType :: Lens' ProjectsLocationsDataSetsFhirStoresFhirPatch (Maybe Text)
pldsfsfpUploadType
  = lens _pldsfsfpUploadType
      (\ s a -> s{_pldsfsfpUploadType = a})

-- | Multipart request metadata.
pldsfsfpPayload :: Lens' ProjectsLocationsDataSetsFhirStoresFhirPatch HTTPBody
pldsfsfpPayload
  = lens _pldsfsfpPayload
      (\ s a -> s{_pldsfsfpPayload = a})

-- | The name of the resource to update.
pldsfsfpName :: Lens' ProjectsLocationsDataSetsFhirStoresFhirPatch Text
pldsfsfpName
  = lens _pldsfsfpName (\ s a -> s{_pldsfsfpName = a})

-- | JSONP
pldsfsfpCallback :: Lens' ProjectsLocationsDataSetsFhirStoresFhirPatch (Maybe Text)
pldsfsfpCallback
  = lens _pldsfsfpCallback
      (\ s a -> s{_pldsfsfpCallback = a})

instance GoogleRequest
           ProjectsLocationsDataSetsFhirStoresFhirPatch
         where
        type Rs ProjectsLocationsDataSetsFhirStoresFhirPatch
             = HTTPBody
        type Scopes
               ProjectsLocationsDataSetsFhirStoresFhirPatch
             = '["https://www.googleapis.com/auth/cloud-platform"]
        requestClient
          ProjectsLocationsDataSetsFhirStoresFhirPatch'{..}
          = go _pldsfsfpName _pldsfsfpXgafv
              _pldsfsfpUploadProtocol
              _pldsfsfpAccessToken
              _pldsfsfpUploadType
              _pldsfsfpCallback
              (Just AltJSON)
              _pldsfsfpPayload
              healthcareService
          where go
                  = buildClient
                      (Proxy ::
                         Proxy
                           ProjectsLocationsDataSetsFhirStoresFhirPatchResource)
                      mempty
