pragma solidity 0.5.16;

import "../../base/sushi-base/MasterChefStrategyWithBuyback.sol";

contract BasketStrategy_BASK_ETH is MasterChefStrategyWithBuyback {

  address public bask_eth_unused; // just a differentiator for the bytecode
  address public constant baskEthLp = address(0x34d25a4749867ef8b62a0cd1e2d7b4f7af167e01);
  address public constant masterChef = address(0xDB9daa0a50B33e4fe9d0ac16a1Df1d335F96595e2);
  address public constant basket = address(0x44564d0bd94343f72E3C8a0D22308B7Fa71DB0Bb);
  address public constant weth = address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

  constructor() public {}

  function initializeStrategy(
    address _storage,
    address _vault,
    address _distributionPool
  ) public initializer {
    uint256 poolId = 2;
    MasterChefStrategyWithBuyback.initializeBaseStrategy(
      _storage,
      baskEthLp,
      _vault,
      masterChef,
      basket,
      poolId,
      true, // is LP asset
      false, // use Uniswap
      _distributionPool,
      5000
    );
    uniswapRoutes[weth] = [basket, weth]; // swaps to weth
    uniswapRoutes[basket] = [weth, basket];
    setSell(true);
    setSellFloor(1e16);
  }
}
