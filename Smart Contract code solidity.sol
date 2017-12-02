pragma solidity ^0.4.4; 
contract Token { 
    function totalSupply() public constant returns(uint256 supply) {}  /// @return total amount of tokens
	/// @param _owner The address from which the balance will be retrieved 
	
    function balanceOf(address _owner) public constant returns (uint256 balance) {} /// @return The balance
    function transfer(address _to, uint256 _value) public returns (bool success) {} //The amount of token to be transferred to address @return Whether the transfer was successful or not

    function transferFrom(address _from, address _to,uint256 _value) public  returns (bool success) {} //@param _to The address of the recipient 
	/// @param _value The amount of token to be transferred 
	/// @return Whether the transfer was successful
	
   function approve(address _spender, uint256 _value) public returns (bool success) {} /// @param _value The amount of wei to be approved for transfer 
   /// @return Whether the approval was successful or not
   
   function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {} /// @param _owner The address of the account owning tokens 
   /// @param _spender The address of the account able to transfer the tokens 
   /// @return Amount of remaining tokens allowed to spent
     event Transfer(address indexed _from, address indexed _to,uint256 _value); 
     event Approval(address indexed _owner,address indexed _spender, uint256 _value); 
     } 


contract StandardToken is Token { 
   function transfer(address _to,uint256 _value) public returns (bool success) { 
 //If your token leaves out totalSupply and can issue more tokens as time goes on, you need to check if it doesn't wrap.
if(balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]){ 
    if (balances[msg.sender] >= _value && _value > 0) { 
        balances[msg.sender] -= _value;
        balances[_to] += _value; 
        Transfer(msg.sender, _to,_value); return true; 
    } else {return false;}
 } 
 }
function transferFrom(address _from, address _to,uint256 _value) public returns (bool success) {
// same as function transfer
if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value > balances[_to]) { 
    if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
      balances[_to] += _value; 
      balances[_from] -= _value;
allowed[_from][msg.sender] -= _value; Transfer(_from,_to, _value); return true; } else { return
false; } } }
function balanceOf(address _owner) public constant returns (uint256 balance) { return balances[_owner];
} function approve(address _spender, uint256 _value) public returns
(bool success) 
{ allowed[msg.sender][_spender] = _value;
Approval(msg.sender, _spender, _value); return true;
} function allowance(address _owner, address _spender) public 
constant returns (uint256 remaining) 
{ return
allowed[_owner][_spender]; } mapping (address => uint256) balances; mapping (address => mapping (address =>
uint256)) allowed; uint256 public totalSupply; } //name this 
 
contract ERC20Token is StandardToken { function () public {

 }
function ERC20Token() public { 
    balances[msg.sender] = 100000;

totalSupply = 100000; //

} 

function approveAndCall(address _spender, uint256 _value, bytes _extraData) public returns (bool success) { 
    allowed[msg.sender][_spender] = _value;

Approval(msg.sender, _spender, _value); 
if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData))
{ revert(); } return true; } }