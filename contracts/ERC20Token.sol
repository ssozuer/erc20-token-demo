pragma solidity  0.7.0;

import "@openzeppelin/contracts/math/SafeMath.sol";

contract ERC20Token {
	using SafeMath for uint256;

  mapping(address => uint256) internal balances;
  mapping(address => mapping(address => uint256)) internal allowed;
  uint256 public totalSupply = 1000;

  string public name = "My ERC20 Token";
  string public symbol = "MET";
  uint8 public decimals = 0;

  constructor () {
    balances[msg.sender] = totalSupply;
    emit Transfer(address(0), msg.sender, totalSupply);
  }

  function transfer(address _to, uint256 _value) public returns (bool) {
    require(_value <= balances[msg.sender]);
    require(_to != address(0));

    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  function approve(address _spender, uint256 _value) public returns(bool) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  function transferFrom (address _from, address _to, uint256 _value) public returns(bool) {
    require(balances[_from] >= _value);
    require(allowed[_from][msg.sender] >= _value);
    require(_to != address(0));

    balances[_from] = balances[_from].sub(_value);
    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    emit Transfer(_from, _to, _value);
    return true;
  }

  function allownce(address _owner, address _spender) public view returns(uint256) {
    return allowed[_owner][_spender];
  } 

  function balanceOf(address _owner) public view returns (uint256) {
    return balances[_owner];
  }



  /// @dev Events
  event Transfer (
    address indexed from,
    address indexed to,
    uint256 value
  );

  event Approval(
    address indexed owner,
    address indexed spender,
    uint256 value
  );

}