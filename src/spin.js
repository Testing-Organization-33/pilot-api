// DASH-901: apply the house edge to spin payouts.
exports.spinPayout = (bet, mult) => bet * mult * 10;
