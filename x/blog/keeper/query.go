package keeper

import (
	"frost/x/blog/types"
)

var _ types.QueryServer = Keeper{}
