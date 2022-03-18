{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE StrictData #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports #-}
{-# OPTIONS_GHC -fno-warn-name-shadowing #-}
{-# OPTIONS_GHC -fno-warn-unused-binds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- |
-- Module      : Network.Google.Monitoring.Services.Create
-- Copyright   : (c) 2015-2022 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay+gogol@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Create a Service.
--
-- /See:/ <https://cloud.google.com/monitoring/api/ Cloud Monitoring API Reference> for @monitoring.services.create@.
module Network.Google.Monitoring.Services.Create
  ( -- * Resource
    MonitoringServicesCreateResource,

    -- ** Constructing a Request
    newMonitoringServicesCreate,
    MonitoringServicesCreate,
  )
where

import Network.Google.Monitoring.Types
import qualified Network.Google.Prelude as Core

-- | A resource alias for @monitoring.services.create@ method which the
-- 'MonitoringServicesCreate' request conforms to.
type MonitoringServicesCreateResource =
  "v3"
    Core.:> Core.Capture "parent" Core.Text
    Core.:> "services"
    Core.:> Core.QueryParam "$.xgafv" Xgafv
    Core.:> Core.QueryParam "access_token" Core.Text
    Core.:> Core.QueryParam "callback" Core.Text
    Core.:> Core.QueryParam "serviceId" Core.Text
    Core.:> Core.QueryParam "uploadType" Core.Text
    Core.:> Core.QueryParam "upload_protocol" Core.Text
    Core.:> Core.QueryParam "alt" Core.AltJSON
    Core.:> Core.ReqBody '[Core.JSON] Service
    Core.:> Core.Post '[Core.JSON] Service

-- | Create a Service.
--
-- /See:/ 'newMonitoringServicesCreate' smart constructor.
data MonitoringServicesCreate = MonitoringServicesCreate
  { -- | V1 error format.
    xgafv :: (Core.Maybe Xgafv),
    -- | OAuth access token.
    accessToken :: (Core.Maybe Core.Text),
    -- | JSONP
    callback :: (Core.Maybe Core.Text),
    -- | Required. Resource name (https:\/\/cloud.google.com\/monitoring\/api\/v3#project/name) of the parent workspace. The format is: projects\/[PROJECT/ID/OR/NUMBER]
    parent :: Core.Text,
    -- | Multipart request metadata.
    payload :: Service,
    -- | Optional. The Service id to use for this Service. If omitted, an id will be generated instead. Must match the pattern [a-z0-9-]+
    serviceId :: (Core.Maybe Core.Text),
    -- | Legacy upload protocol for media (e.g. \"media\", \"multipart\").
    uploadType :: (Core.Maybe Core.Text),
    -- | Upload protocol for media (e.g. \"raw\", \"multipart\").
    uploadProtocol :: (Core.Maybe Core.Text)
  }
  deriving (Core.Eq, Core.Show, Core.Generic)

-- | Creates a value of 'MonitoringServicesCreate' with the minimum fields required to make a request.
newMonitoringServicesCreate ::
  -- |  Required. Resource name (https:\/\/cloud.google.com\/monitoring\/api\/v3#project/name) of the parent workspace. The format is: projects\/[PROJECT/ID/OR/NUMBER] See 'parent'.
  Core.Text ->
  -- |  Multipart request metadata. See 'payload'.
  Service ->
  MonitoringServicesCreate
newMonitoringServicesCreate parent payload =
  MonitoringServicesCreate
    { xgafv = Core.Nothing,
      accessToken = Core.Nothing,
      callback = Core.Nothing,
      parent = parent,
      payload = payload,
      serviceId = Core.Nothing,
      uploadType = Core.Nothing,
      uploadProtocol = Core.Nothing
    }

instance Core.GoogleRequest MonitoringServicesCreate where
  type Rs MonitoringServicesCreate = Service
  type
    Scopes MonitoringServicesCreate =
      '[ "https://www.googleapis.com/auth/cloud-platform",
         "https://www.googleapis.com/auth/monitoring"
       ]
  requestClient MonitoringServicesCreate {..} =
    go
      parent
      xgafv
      accessToken
      callback
      serviceId
      uploadType
      uploadProtocol
      (Core.Just Core.AltJSON)
      payload
      monitoringService
    where
      go =
        Core.buildClient
          ( Core.Proxy ::
              Core.Proxy MonitoringServicesCreateResource
          )
          Core.mempty