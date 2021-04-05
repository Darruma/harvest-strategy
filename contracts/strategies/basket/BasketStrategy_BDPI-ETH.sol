pragma solidity 0.5.16;

import "../../base/sushi-base/MasterChefStrategyWithBuyback.sol";

contract BasketStrategy_BDPI_ETH is MasterChefStrategyWithBuyback {

  address public bdpi_eth_unused; // just a differentiator for the bytecode
  address public constant bdpiEthLp = address(0x8d782c5806607e9aafb2ac38c1da3838edf8bd03);
  address public constant masterChef = address(0xDB9daa0a50B33e4fe9d0ac16a1Df1d335F96595e2);
  address public constant basket = address(0x44564d0bd94343f72E3C8a0D22308B7Fa71DB0Bb);
  address public constant bdpi = address(0x0309c98B1bffA350bcb3F9fB9780970CA32a5060);
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
      bdpiEthLp,
      _vault,
      masterChef,
      basket,
      poolId,
      true, // is LP asset
      false, // use Uniswap
      _distributionPool,
      5000
    );
    uniswapRoutes[weth] = [bdpi, weth]; // swaps to weth
    uniswapRoutes[bdpi] = [weth, bdpi];
    setSell(true);
    setSellFloor(1e16);
  }
}
