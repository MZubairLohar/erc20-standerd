pragma solidity ^0.6.0;

contract corecis{
    
    //constructor
    
    constructor(string memory name, string memory symbol, uint256 initialSupply, uint256 decimals) public{
        _name = name;
        _symbol = symbol;
        _totalSupply = initialSupply;
        _decimals = decimals;
         capped = (2*initialSupply);
         
    }
    
    //state variable
    
    address public owner = msg.sender;
    
    string internal _name;
    
    string internal _symbol;
    
    uint256 internal _totalSupply;
    
    uint256 internal _decimals;
    
    uint256 internal capped;
    
    
    //events
    
    event Transfer(address from, address to, uint256 value);
    event Approval(address owner, address spender, uint256 value);
    
    //mappings
    
    mapping( address => uint256 ) internal BalanceOf;
    mapping( address => mapping(address => uint256)) internal Allowed;
    
    
    
    
    //modifier
    
    
    
    
    
    
    //function
    
    //view
    
    function name() public view returns(string memory){
        return _name;
    }
    
    function symbol() public view returns(string memory){
        return _symbol;
    }
    
    function totalSupply() public view returns(uint256){
        return _totalSupply;
    }
    
    function decimals() public view returns(uint256){
        return _decimals;
    }
    
    function balanceOf( address _owner) public view returns(uint256){
        return BalanceOf[_owner];
    }
    
    function allowance(address _owner, address _spender) public view returns(uint256){
        return(Allowed[_owner][_spender]);
    }
    
    
    
    
    
    //transfer
    
    
    function transfer(address _to, uint256 _value) public returns(bool success){
        require(_to != address(0),"invalid address");
        require(_value >= 0 && _value<= BalanceOf[msg.sender], " invalid value");
        BalanceOf[_to] += _value; 
        BalanceOf[msg.sender] -= _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
        require(_from != address(0) && _to != address(0), "invalid address");
        require(_value <= BalanceOf[_from], " invalid amount");
        require(_value <= Allowed[_from][msg.sender]);
        Allowed[_from][msg.sender] -= _value;
        BalanceOf[_from] -= _value;
        BalanceOf[_to] += _value;
         emit Transfer(_from, _to, _value);
        return true;
    }
    
    function allowance(address _spender, uint256 _value) public returns(bool success){
        require(_spender != address(0), "invalid address");
        Allowed[msg.sender][_spender] = _value;
        return true;
    }
    
    
    
   
}