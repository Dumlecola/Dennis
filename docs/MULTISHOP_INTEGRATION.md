# Dennis WMS — unified multi-shop implementation

Status: work in progress. The uploaded 2.2.14 ZIP does not yet provide feature parity for connected shops.

## Required architecture

1. Extract plugin source files from the ZIP into version-controlled source.
2. Route both local and connected orders through a common shop-aware order adapter and shared renderer.
3. Maintain one authoritative physical stock ledger with idempotent operation IDs; never double-decrement stock on sync retries.
4. Scope every mutation and audit event to shop ID, remote order/product ID and actor.
5. Support stocktakes, receiving, returns, batch/expiry, locations, prepacked units, tracking, reports and printing in connected shops.
6. Test with at least two connected staging shops, concurrent orders, failed API calls, retries and deleted orders.

## Safety

Remote picking/packing flags in 2.2.14 do not automatically update WooCommerce stock or order status. Do not deploy an untested unified stock engine to production.

## Current checks

`scripts/check-wms-package.sh` checks the ZIP structure and PHP syntax. It does not test feature parity or WooCommerce API integrations.
