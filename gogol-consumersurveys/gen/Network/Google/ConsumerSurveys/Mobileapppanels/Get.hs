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
-- Module      : Network.Google.ConsumerSurveys.Mobileapppanels.Get
-- Copyright   : (c) 2015-2022 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay+gogol@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Retrieves a MobileAppPanel that is available to the authenticated user.
--
-- /See:/ <https://developers.google.com/surveys/ Consumer Surveys API Reference> for @consumersurveys.mobileapppanels.get@.
module Network.Google.ConsumerSurveys.Mobileapppanels.Get
  ( -- * Resource
    ConsumerSurveysMobileapppanelsGetResource,

    -- ** Constructing a Request
    newConsumerSurveysMobileapppanelsGet,
    ConsumerSurveysMobileapppanelsGet,
  )
where

import Network.Google.ConsumerSurveys.Types
import qualified Network.Google.Prelude as Core

-- | A resource alias for @consumersurveys.mobileapppanels.get@ method which the
-- 'ConsumerSurveysMobileapppanelsGet' request conforms to.
type ConsumerSurveysMobileapppanelsGetResource =
  "consumersurveys"
    Core.:> "v2"
    Core.:> "mobileAppPanels"
    Core.:> Core.Capture "panelId" Core.Text
    Core.:> Core.QueryParam "alt" Core.AltJSON
    Core.:> Core.Get '[Core.JSON] MobileAppPanel

-- | Retrieves a MobileAppPanel that is available to the authenticated user.
--
-- /See:/ 'newConsumerSurveysMobileapppanelsGet' smart constructor.
newtype ConsumerSurveysMobileapppanelsGet = ConsumerSurveysMobileapppanelsGet
  { -- | External URL ID for the panel.
    panelId :: Core.Text
  }
  deriving (Core.Eq, Core.Show, Core.Generic)

-- | Creates a value of 'ConsumerSurveysMobileapppanelsGet' with the minimum fields required to make a request.
newConsumerSurveysMobileapppanelsGet ::
  -- |  External URL ID for the panel. See 'panelId'.
  Core.Text ->
  ConsumerSurveysMobileapppanelsGet
newConsumerSurveysMobileapppanelsGet panelId =
  ConsumerSurveysMobileapppanelsGet {panelId = panelId}

instance
  Core.GoogleRequest
    ConsumerSurveysMobileapppanelsGet
  where
  type
    Rs ConsumerSurveysMobileapppanelsGet =
      MobileAppPanel
  type
    Scopes ConsumerSurveysMobileapppanelsGet =
      '[ "https://www.googleapis.com/auth/consumersurveys",
         "https://www.googleapis.com/auth/consumersurveys.readonly",
         "https://www.googleapis.com/auth/userinfo.email"
       ]
  requestClient ConsumerSurveysMobileapppanelsGet {..} =
    go
      panelId
      (Core.Just Core.AltJSON)
      consumerSurveysService
    where
      go =
        Core.buildClient
          ( Core.Proxy ::
              Core.Proxy ConsumerSurveysMobileapppanelsGetResource
          )
          Core.mempty