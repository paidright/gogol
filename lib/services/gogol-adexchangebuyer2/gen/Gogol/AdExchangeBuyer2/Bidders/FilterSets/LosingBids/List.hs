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
-- Module      : Gogol.AdExchangeBuyer2.Bidders.FilterSets.LosingBids.List
-- Copyright   : (c) 2015-2022 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay+gogol@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- List all reasons for which bids lost in the auction, with the number of bids that lost for each reason.
--
-- /See:/ <https://developers.google.com/authorized-buyers/apis/reference/rest/ Ad Exchange Buyer API II Reference> for @adexchangebuyer2.bidders.filterSets.losingBids.list@.
module Gogol.AdExchangeBuyer2.Bidders.FilterSets.LosingBids.List
  ( -- * Resource
    AdExchangeBuyer2BiddersFilterSetsLosingBidsListResource,

    -- ** Constructing a Request
    newAdExchangeBuyer2BiddersFilterSetsLosingBidsList,
    AdExchangeBuyer2BiddersFilterSetsLosingBidsList,
  )
where

import Gogol.AdExchangeBuyer2.Types
import qualified Gogol.Prelude as Core

-- | A resource alias for @adexchangebuyer2.bidders.filterSets.losingBids.list@ method which the
-- 'AdExchangeBuyer2BiddersFilterSetsLosingBidsList' request conforms to.
type AdExchangeBuyer2BiddersFilterSetsLosingBidsListResource =
  "v2beta1"
    Core.:> Core.Capture "filterSetName" Core.Text
    Core.:> "losingBids"
    Core.:> Core.QueryParam "$.xgafv" Xgafv
    Core.:> Core.QueryParam "access_token" Core.Text
    Core.:> Core.QueryParam "callback" Core.Text
    Core.:> Core.QueryParam "pageSize" Core.Int32
    Core.:> Core.QueryParam "pageToken" Core.Text
    Core.:> Core.QueryParam "uploadType" Core.Text
    Core.:> Core.QueryParam "upload_protocol" Core.Text
    Core.:> Core.QueryParam "alt" Core.AltJSON
    Core.:> Core.Get '[Core.JSON] ListLosingBidsResponse

-- | List all reasons for which bids lost in the auction, with the number of bids that lost for each reason.
--
-- /See:/ 'newAdExchangeBuyer2BiddersFilterSetsLosingBidsList' smart constructor.
data AdExchangeBuyer2BiddersFilterSetsLosingBidsList = AdExchangeBuyer2BiddersFilterSetsLosingBidsList
  { -- | V1 error format.
    xgafv :: (Core.Maybe Xgafv),
    -- | OAuth access token.
    accessToken :: (Core.Maybe Core.Text),
    -- | JSONP
    callback :: (Core.Maybe Core.Text),
    -- | Name of the filter set that should be applied to the requested metrics. For example: - For a bidder-level filter set for bidder 123: @bidders\/123\/filterSets\/abc@ - For an account-level filter set for the buyer account representing bidder 123: @bidders\/123\/accounts\/123\/filterSets\/abc@ - For an account-level filter set for the child seat buyer account 456 whose bidder is 123: @bidders\/123\/accounts\/456\/filterSets\/abc@
    filterSetName :: Core.Text,
    -- | Requested page size. The server may return fewer results than requested. If unspecified, the server will pick an appropriate default.
    pageSize :: (Core.Maybe Core.Int32),
    -- | A token identifying a page of results the server should return. Typically, this is the value of ListLosingBidsResponse.nextPageToken returned from the previous call to the losingBids.list method.
    pageToken :: (Core.Maybe Core.Text),
    -- | Legacy upload protocol for media (e.g. \"media\", \"multipart\").
    uploadType :: (Core.Maybe Core.Text),
    -- | Upload protocol for media (e.g. \"raw\", \"multipart\").
    uploadProtocol :: (Core.Maybe Core.Text)
  }
  deriving (Core.Eq, Core.Show, Core.Generic)

-- | Creates a value of 'AdExchangeBuyer2BiddersFilterSetsLosingBidsList' with the minimum fields required to make a request.
newAdExchangeBuyer2BiddersFilterSetsLosingBidsList ::
  -- |  Name of the filter set that should be applied to the requested metrics. For example: - For a bidder-level filter set for bidder 123: @bidders\/123\/filterSets\/abc@ - For an account-level filter set for the buyer account representing bidder 123: @bidders\/123\/accounts\/123\/filterSets\/abc@ - For an account-level filter set for the child seat buyer account 456 whose bidder is 123: @bidders\/123\/accounts\/456\/filterSets\/abc@ See 'filterSetName'.
  Core.Text ->
  AdExchangeBuyer2BiddersFilterSetsLosingBidsList
newAdExchangeBuyer2BiddersFilterSetsLosingBidsList filterSetName =
  AdExchangeBuyer2BiddersFilterSetsLosingBidsList
    { xgafv = Core.Nothing,
      accessToken = Core.Nothing,
      callback = Core.Nothing,
      filterSetName = filterSetName,
      pageSize = Core.Nothing,
      pageToken = Core.Nothing,
      uploadType = Core.Nothing,
      uploadProtocol = Core.Nothing
    }

instance
  Core.GoogleRequest
    AdExchangeBuyer2BiddersFilterSetsLosingBidsList
  where
  type
    Rs
      AdExchangeBuyer2BiddersFilterSetsLosingBidsList =
      ListLosingBidsResponse
  type
    Scopes
      AdExchangeBuyer2BiddersFilterSetsLosingBidsList =
      '[Adexchange'Buyer]
  requestClient
    AdExchangeBuyer2BiddersFilterSetsLosingBidsList {..} =
      go
        filterSetName
        xgafv
        accessToken
        callback
        pageSize
        pageToken
        uploadType
        uploadProtocol
        (Core.Just Core.AltJSON)
        adExchangeBuyer2Service
      where
        go =
          Core.buildClient
            ( Core.Proxy ::
                Core.Proxy
                  AdExchangeBuyer2BiddersFilterSetsLosingBidsListResource
            )
            Core.mempty
