package keeper_test

import (
	"context"
	"testing"

	keepertest "frost/testutil/keeper"
	"frost/x/blog/keeper"
	"frost/x/blog/types"
	sdk "github.com/cosmos/cosmos-sdk/types"
)

func setupMsgServer(t testing.TB) (types.MsgServer, context.Context) {
	k, ctx := keepertest.BlogKeeper(t)
	return keeper.NewMsgServerImpl(*k), sdk.WrapSDKContext(ctx)
}
