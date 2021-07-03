// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

    /**
    * @dev Multiplies two numbers, throws on overflow.
    */
    function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
        if (a == 0) {
            return 0;
        }
        c = a * b;
        assert(c / a == b);
        return c;
    }

    /**
    * @dev Integer division of two numbers, truncating the quotient.
    */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        // uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return a / b;
    }

    /**
    * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
    */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    /**
    * @dev Adds two numbers, throws on overflow.
    */
    function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a + b;
        assert(c >= a);
        return c;
    }

}
interface IERC20 {

    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}



contract PromiseBnbLottery {

    using SafeMath for uint256;

    IERC20 public _promiseToken;

    address public _promiseContractAddress;

    IUniswapV2Router02 public immutable uniswapV2Router;

    address public _coordinator;

    uint256 public _coordinatorBalance = 0;

    mapping(address => address[]) public _partnerPlayerList;

    mapping(address => Partner) public _partnerList;

    mapping(uint256 => address) public _partnerIdMapping;

    mapping(address => PartnerPayment[]) _paymentList;

    mapping(address => Player) public _PlayerList;

    mapping(uint256 => Pool) public _pools;

    mapping(uint256 => Game) public _runningGames;

    mapping(uint256 => address[]) public _gamePlayers;

    mapping(uint256 => Winner) public _winnerList;

    uint256 public _defaultPartnerId;

    uint256 public _startingPartnerId = 1000000;

    uint256 public _nextPlayerId = 0;

    uint256 public _nextGameId = 0;

    uint256 public _nextPartnerId;

    uint256 public _partnerFee;

    uint256 public _maxPartnerFee;

    uint256 public _coordinatorFee;

    uint256 public _maxCoordinatorFee;

    uint256 public _minimumPartnerWithdrawal;

    uint256 public _totalPartnerProfit = 0;

    uint256 public _totalPlayerProfit = 0;

    uint256 public _poolId = 0;

    uint256 public _gamesPlayedTotal = 0;

    bool public _nextBurn = true;

    address public _burnAddress;

    uint256 public _minBalanceToBurn;


    struct Pool{
        uint256 id;
        uint256 maxPlayers;
        uint256 entryAmount;
        uint256 timeout;
    }

    struct Game{
        uint256 id;
        uint256 poolId;
        uint256 winnableAmount;
        uint256 createdAt;
        uint256 countParticipants;
        bool open;
        bool completed;
        bool forcePlay;
    }

    struct Partner {
        uint256 id;
        address payable payTo;
        uint256 balance;
    }


    struct Player{
        uint256 id;
        address playerAddress;
        uint256 amountPlayed;
        uint256 amountWon;
        address partner;
    }

    struct PartnerPayment{
        Partner partner;
        uint256 amount;
        uint256 time;
    }

    struct Winner{
        address payable adr;
        uint256 amount;
        uint256 poolId;
        uint256 time;
    }

    event GameFinished(uint256 gameId, uint256 poolId, uint256 amountWon, address winner);
    event NewPartner(uint256 partnerId, address partner);
    event NewPartnerWithdrawal(uint256 partnerId, address partner, uint256 amount);
    event PoolCreated(uint256 poolId, uint256 maxPlayers, uint256 entryAmount, uint256 timeout);
    event NewPlayer(uint256 playerId, address player);
    event JoinedGame(uint256 gameId, uint256 poolId, address player, uint256 amount, uint256 winnableAmount);
    event NewPartnerPayment(address partnerAddress, address player, uint256 paymentAmount);
    event GameHasBeenForced(uint256 gameId, uint256 poolId, address by, uint256 gameCreatedAt);


    constructor(uint256 maxpFee, uint256 pFee, uint256 cFee, uint256 maxcFee, uint256 minimumPw, uint256 minBalanceToBurn) public {

        require(pFee <= maxpFee, 'Initial partner fee can not exceed maxPartnerFee');
        require(cFee <= maxcFee, 'Initial coordinator fee can not exceed maxCoordinatorFee');
        require(minBalanceToBurn > 0);

        _coordinator = msg.sender;
        _nextPartnerId = _startingPartnerId;
        _defaultPartnerId = _nextPartnerId;
        _partnerFee = pFee;
        _maxPartnerFee = maxpFee;
        _coordinatorFee = cFee;
        _maxCoordinatorFee = maxcFee;
        _minimumPartnerWithdrawal = minimumPw;
        _minBalanceToBurn = minBalanceToBurn;
        createPartner();
        _promiseContractAddress = address(0xcbcCf14B051947BDcd1E20b77015208a1AD5EA25);
        _promiseToken = IERC20(_promiseContractAddress);
        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x05fF2B0DB69458A0750badebc4f9e13aDd608C7F);
        uniswapV2Router = _uniswapV2Router;
        _burnAddress = address(0x000000000000000000000000000000000000dEaD);

    }




    function createPartner() public {
        require(!isPartner(), 'You are already a registered Partner.');
        require(msg.sender != address(0x0), 'Unable to create Partner from 0x0 address');


        _partnerList[msg.sender] = Partner(_nextPartnerId, msg.sender, 0);
        _partnerIdMapping[_nextPartnerId] = msg.sender;
        emit NewPartner(_nextPartnerId, msg.sender);
        _nextPartnerId = _nextPartnerId.add(1);

    }




    function getPartner() public view returns(uint256, address, uint256){
        return (_partnerList[msg.sender].id, _partnerList[msg.sender].payTo, _partnerList[msg.sender].balance);
    }

    function isPartner() public view returns(bool){
        return _partnerList[msg.sender].id > 0;
    }


    function getCountPartners() public view returns(uint256){
        return _nextPartnerId.sub(_startingPartnerId);
    }


    function updatePartnerFee(uint256 fee) public coordinatorOnly{
        require(fee <= _maxPartnerFee, 'New fee exceeds maximum partner fee');
        _partnerFee = fee;
    }

    function updateCoordinatorFee(uint256 fee) public coordinatorOnly{
        require(fee <= _maxCoordinatorFee, 'New fee exceeds maximum coordinator fee');
        _coordinatorFee = fee;
    }


    function partnerWithdrawal() public payable requirePartner{
        require(_partnerList[msg.sender].balance >= _minimumPartnerWithdrawal, 'Your balance is less than the minimum withdrawal limit.');
        _paymentList[msg.sender].push(PartnerPayment(_partnerList[msg.sender], _partnerList[msg.sender].balance, now));
        uint256 wAmount = _partnerList[msg.sender].balance;
        _partnerList[msg.sender].payTo.transfer(wAmount);
        _partnerList[msg.sender].balance = 0;
        emit NewPartnerWithdrawal(_partnerList[msg.sender].id, msg.sender, wAmount);
    }

    function getCountPartnerWithdrawals() public view requirePartner returns(uint256){
        return _paymentList[msg.sender].length;
    }

    function getPartnerWithdrawal(uint256 index) public view requirePartner returns(uint256, uint256){
        require(index < getCountPartnerWithdrawals(), 'Out of index');
        return (_paymentList[msg.sender][index].amount, _paymentList[msg.sender][index].time);
    }


    function createPool(uint256 maxPlayers, uint256 entryAmount, uint256 timeout) public coordinatorOnly {
        require(maxPlayers > 1, 'A pool need to have at least 2 players.');
        require(entryAmount > 0, 'Entry amount need to be greater than 0.');
        require(timeout >= 300, 'A pool need to run at least 300 seconds.');

        for(uint256 i = 0; i < _poolId; i++){
            if(_pools[i].maxPlayers == maxPlayers && _pools[i].entryAmount == entryAmount && _pools[i].timeout == timeout){
                revert('A pool with the same settings already exists.');

            }
        }

        _pools[_poolId] = Pool(_poolId, maxPlayers, entryAmount, timeout);
        emit PoolCreated(_poolId, maxPlayers, entryAmount, timeout);
        createGame(_poolId);
        _poolId = _poolId.add(1);


    }

    function isPool(uint256 id) public view returns(bool){
        return _pools[id].maxPlayers > 0;
    }


    function play(uint256 poolId, uint256 partnerId) public payable{

        require(isPool(poolId), 'pool not exists');
        require(msg.value >= _pools[poolId].entryAmount, 'Entry amount too low');
        require(!isJoined(poolId, _runningGames[poolId].id), 'User already joined to this pool. Join the next round or enter another Pool');

        if(!isPlayer(msg.sender)){
            createPlayer(getPartnerById(partnerId));
        }

        if(_runningGames[poolId].countParticipants == 0){
            _runningGames[poolId].createdAt = now;
        }

        _gamePlayers[_runningGames[poolId].id].push(msg.sender);
        _runningGames[poolId].countParticipants = _runningGames[poolId].countParticipants.add(1);
        (uint256 cFee, uint256 pFee) = calcFees(msg.value);
        _totalPartnerProfit = _totalPartnerProfit.add(pFee);
        uint256 addToPool = msg.value.sub(cFee).sub(pFee);
        _runningGames[poolId].winnableAmount = _runningGames[poolId].winnableAmount.add(addToPool);
        _partnerList[_PlayerList[msg.sender].partner].balance = _partnerList[_PlayerList[msg.sender].partner].balance.add(pFee);
        emit NewPartnerPayment(_PlayerList[msg.sender].partner, msg.sender, pFee);
        _coordinatorBalance = _coordinatorBalance.add(cFee);
        emit JoinedGame(_runningGames[poolId].id, poolId, msg.sender, msg.value, _runningGames[poolId].winnableAmount);
        completeGame(poolId);

    }

    function completeGame(uint256 poolId) private{
        if(_runningGames[poolId].forcePlay || _runningGames[poolId].countParticipants == _pools[poolId].maxPlayers){

            uint256 winnerIndex = randWinner(_runningGames[poolId].countParticipants);
            address payable winner = payable(_gamePlayers[_runningGames[poolId].id][winnerIndex]);
            winner.transfer(_runningGames[poolId].winnableAmount);
            _winnerList[_runningGames[poolId].id] = Winner({
            adr: winner,
            amount: _runningGames[poolId].winnableAmount,
            poolId: poolId,
            time: now
            });
            _gamesPlayedTotal = _gamesPlayedTotal.add(1);
            _runningGames[poolId].open = false;
            _runningGames[poolId].completed = true;
            _totalPlayerProfit = _totalPlayerProfit.add(_runningGames[poolId].winnableAmount);
            emit GameFinished(_runningGames[poolId].id, poolId, _runningGames[poolId].winnableAmount, winner);
            createGame(poolId);

            if(_coordinatorBalance >= _minBalanceToBurn){
                if(_nextBurn){
                    burn();
                }else{
                    addLiquidity();
                }
                _nextBurn = !_nextBurn;
            }
        }

    }

    function calcFees(uint256 value) private view returns(uint256, uint256){
        return (value.mul(_coordinatorFee).div(100) , value.mul(_partnerFee).div(100));
    }

    function getWinner(uint256 gameId) public view returns(address payable, uint256, uint256, uint256){
        return (_winnerList[gameId].adr, _winnerList[gameId].amount, _winnerList[gameId].poolId, _winnerList[gameId].time);
    }


    function createGame(uint256 poolId) private{
        _runningGames[poolId] = Game({
        id: _nextGameId,
        poolId: poolId,
        winnableAmount: 0,
        createdAt: now,
        open: true,
        completed: false,
        countParticipants: 0,
        forcePlay: false
        });
        _nextGameId = _nextGameId.add(1);
    }

    function getPartnerById(uint256 partnerId) public view returns(address){

        if(_partnerIdMapping[partnerId] != address(0x0)){
            return _partnerIdMapping[partnerId];
        }

        return getDefaultPartner();
    }


    function getDefaultPartner() public view returns(address){
        return _partnerIdMapping[_defaultPartnerId];
    }


    function isPlayer(address playerAddress) public view returns(bool){
        return _PlayerList[playerAddress].playerAddress == playerAddress;
    }

    function createPlayer(address partner) public {
        require(!isPlayer(msg.sender), 'already a player');

        if(partner == msg.sender || partner == address(0x0)){
            partner = getDefaultPartner();
        }

        _PlayerList[msg.sender] = Player({
        id : _nextPlayerId,
        playerAddress: msg.sender,
        amountPlayed: 0,
        amountWon: 0,
        partner: partner
        });
        _partnerPlayerList[partner].push(msg.sender);
        emit NewPlayer(_nextPlayerId, msg.sender);
        _nextPlayerId = _nextPlayerId.add(1);

    }


    function isGameRunning(uint256 pool) public view returns(bool){
        return _runningGames[pool].open && !_runningGames[pool].completed;
    }

    function isJoined(uint256 pool, uint256 gameId) public view returns(bool){
        require(isGameRunning(pool), 'Game need to be running');

        uint256 l = _gamePlayers[gameId].length;
        for(uint256 i = 0; i < l; i++){
            if(_gamePlayers[gameId][i] == msg.sender){
                return true;
            }
        }


        return false;
    }

    function forcePlay(uint256 poolId, uint256 gameId) public{
        require(
            isPool(poolId) &&
            gameId < _nextGameId &&
            _runningGames[poolId].id == gameId &&
            _runningGames[poolId].open &&
            !_runningGames[poolId].completed &&
            !_runningGames[poolId].forcePlay &&
            _runningGames[poolId].countParticipants > 0 &&
            _runningGames[poolId].createdAt.add(_pools[poolId].timeout) >= now &&
            (_coordinator == msg.sender || isJoined(poolId, gameId))
        , 'force play not possible');


        _runningGames[poolId].forcePlay = true;
        emit GameHasBeenForced(gameId, poolId, msg.sender, _runningGames[poolId].createdAt);
        completeGame(poolId);
    }


    function randWinner(uint256 countPlayers) private view returns(uint256){
        require(countPlayers > 0);

        return uint256(keccak256(abi.encodePacked(now, _coordinatorBalance, block.difficulty, msg.sender, _nextGameId, countPlayers))) % countPlayers;

    }

    function getRunningGameInfo(uint256 poolId) public view returns(uint256, uint256, uint256, uint256, uint256)
    {
        require(isGameRunning(poolId), 'no active pool');
        return (
        _runningGames[poolId].id,
        _runningGames[poolId].poolId,
        _runningGames[poolId].winnableAmount,
        _runningGames[poolId].createdAt,
        _runningGames[poolId].countParticipants
        );

    }



    function burn() private{
        swapTokensToPromise(_coordinatorBalance);
        _promiseToken.approve(address(this), _promiseToken.balanceOf(address(this)));
        _promiseToken.transfer(_burnAddress,_promiseToken.balanceOf(address(this)));
        _coordinatorBalance = 0;
    }

    function addLiquidity() private {
        uint256 half = _coordinatorBalance.div(2);
        uint256 otherHalf = _coordinatorBalance.sub(half);

        swapTokensToPromise(half);

        uint256 cBalance = _promiseToken.balanceOf(address(this));
        _promiseToken.approve(address(uniswapV2Router), cBalance);
        uniswapV2Router.addLiquidityETH{value: otherHalf}(
            _promiseContractAddress,
            cBalance,
            0,
            0,
            _coordinator,
            block.timestamp
        );
        _coordinatorBalance = 0;
    }

    function swapTokensToPromise(uint256 amount) private {
        require(amount <= _coordinatorBalance);
        require(address(this).balance >= amount);

        address[] memory path = new address[](2);
        path[0] = uniswapV2Router.WETH();
        path[1] = _promiseContractAddress;


        uniswapV2Router.swapExactETHForTokensSupportingFeeOnTransferTokens{value: amount}(
            0,
            path,
            address(this),
            block.timestamp
        );

    }

    function setMinBalanceToBurn(uint256 amount) public coordinatorOnly{
        require(amount > 0);
        _minBalanceToBurn = amount;
    }

    function setNextBurn(bool v) public coordinatorOnly{
        _nextBurn = v;
    }

    modifier coordinatorOnly(){
        require(msg.sender == _coordinator, 'Only the coordinator is allowed to execute this method.');
        _;
    }


    modifier requirePartner(){
        require(isPartner(), 'You need to be a registered partner to perform a withdrawal');
        _;

    }



}
