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
-- Module      : Network.Google.FirebaseRules.Projects.Releases.Patch
-- Copyright   : (c) 2015-2022 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay+gogol@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Update a @Release@ via PATCH. Only updates to @ruleset_name@ will be honored. @Release@ rename is not supported. To create a @Release@ use the CreateRelease method.
--
-- /See:/ <https://firebase.google.com/docs/storage/security Firebase Rules API Reference> for @firebaserules.projects.releases.patch@.
module Network.Google.FirebaseRules.Projects.Releases.Patch
  ( -- * Resource
    FirebaseRulesProjectsReleasesPatchResource,

    -- ** Constructing a Request
    newFirebaseRulesProjectsReleasesPatch,
    FirebaseRulesProjectsReleasesPatch,
  )
where

import Network.Google.FirebaseRules.Types
import qualified Network.Google.Prelude as Core

-- | A resource alias for @firebaserules.projects.releases.patch@ method which the
-- 'FirebaseRulesProjectsReleasesPatch' request conforms to.
type FirebaseRulesProjectsReleasesPatchResource =
  "v1"
    Core.:> Core.Capture "name" Core.Text
    Core.:> Core.QueryParam "$.xgafv" Xgafv
    Core.:> Core.QueryParam "access_token" Core.Text
    Core.:> Core.QueryParam "callback" Core.Text
    Core.:> Core.QueryParam "uploadType" Core.Text
    Core.:> Core.QueryParam "upload_protocol" Core.Text
    Core.:> Core.QueryParam "alt" Core.AltJSON
    Core.:> Core.ReqBody '[Core.JSON] UpdateReleaseRequest
    Core.:> Core.Patch '[Core.JSON] Release

-- | Update a @Release@ via PATCH. Only updates to @ruleset_name@ will be honored. @Release@ rename is not supported. To create a @Release@ use the CreateRelease method.
--
-- /See:/ 'newFirebaseRulesProjectsReleasesPatch' smart constructor.
data FirebaseRulesProjectsReleasesPatch = FirebaseRulesProjectsReleasesPatch
  { -- | V1 error format.
    xgafv :: (Core.Maybe Xgafv),
    -- | OAuth access token.
    accessToken :: (Core.Maybe Core.Text),
    -- | JSONP
    callback :: (Core.Maybe Core.Text),
    -- | Required. Resource name for the project which owns this @Release@. Format: @projects\/{project_id}@
    name :: Core.Text,
    -- | Multipart request metadata.
    payload :: UpdateReleaseRequest,
    -- | Legacy upload protocol for media (e.g. \"media\", \"multipart\").
    uploadType :: (Core.Maybe Core.Text),
    -- | Upload protocol for media (e.g. \"raw\", \"multipart\").
    uploadProtocol :: (Core.Maybe Core.Text)
  }
  deriving (Core.Eq, Core.Show, Core.Generic)

-- | Creates a value of 'FirebaseRulesProjectsReleasesPatch' with the minimum fields required to make a request.
newFirebaseRulesProjectsReleasesPatch ::
  -- |  Required. Resource name for the project which owns this @Release@. Format: @projects\/{project_id}@ See 'name'.
  Core.Text ->
  -- |  Multipart request metadata. See 'payload'.
  UpdateReleaseRequest ->
  FirebaseRulesProjectsReleasesPatch
newFirebaseRulesProjectsReleasesPatch name payload =
  FirebaseRulesProjectsReleasesPatch
    { xgafv = Core.Nothing,
      accessToken = Core.Nothing,
      callback = Core.Nothing,
      name = name,
      payload = payload,
      uploadType = Core.Nothing,
      uploadProtocol = Core.Nothing
    }

instance
  Core.GoogleRequest
    FirebaseRulesProjectsReleasesPatch
  where
  type Rs FirebaseRulesProjectsReleasesPatch = Release
  type
    Scopes FirebaseRulesProjectsReleasesPatch =
      '[ "https://www.googleapis.com/auth/cloud-platform",
         "https://www.googleapis.com/auth/firebase"
       ]
  requestClient FirebaseRulesProjectsReleasesPatch {..} =
    go
      name
      xgafv
      accessToken
      callback
      uploadType
      uploadProtocol
      (Core.Just Core.AltJSON)
      payload
      firebaseRulesService
    where
      go =
        Core.buildClient
          ( Core.Proxy ::
              Core.Proxy
                FirebaseRulesProjectsReleasesPatchResource
          )
          Core.mempty