pragma solidity ^0.8.3;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface IPancakeFactory {
    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);
}

interface IPancakeRouter {
    function WETH() external pure returns (address);

    function factory() external pure returns (address);
}

interface IPancakePair {
    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

contract MyToken {
    using SafeMath for uint256;
    string public Symbol = "MyToken";
    string public Name = "MTN";
    uint256 decimal = 18;
    uint256 TotalSupply = 10 ** uint256(decimal) * (1000000);
    address public taxfee;
    mapping(address => bool) public isExcludedfromFee;
    // mapping(address => bool) public isIncludedfromFee;
    address public immutable pairAddress;
    address public immutable routerAddress;
    address public owner;
    uint256 devTaxFee = 500;
    address[] public holders;

    modifier onlyOnwer() {
        require(owner == msg.sender, "Not the ownner");
        _;
    }

    constructor() {
        owner = msg.sender;
        balanceOf[owner] = TotalSupply;
        IPancakeRouter _router = IPancakeRouter(
            0xD99D1c33F9fC3444f8101754aBC46c52416550D1
        );
        pairAddress = IPancakeFactory(_router.factory()).createPair(
            address(this),
            _router.WETH()
        );
        routerAddress = address(_router);
        isExcludedfromFee[owner] = true;
    }

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public Allowance;

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed amount
    );
    event Approved(address indexed from, uint256 indexed amount);
    event Mint(address indexed from, uint256 indexed amount);
    error InvalidAddress();

    function transfer(address to, uint256 amount) public returns (bool) {
        require(amount > 0, "Invalid amount");
        require(to != address(0), "invalid address");
        require(balanceOf[msg.sender] > 0, "invalid balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        bool isRecipient = false;
        for (uint256 i = 0; i < holders.length; i++) {
            //   address holder = holders[i];
            if (holders[i] == to) {
                isRecipient = true;
                break;
            }
            if (!isRecipient) {
                holders.push(to);
            }
        }
        emit Transfer(msg.sender, to, amount);
        if (to == pairAddress) {
            _transfer(msg.sender, to, amount);
        }
        return (true);
    }

    function Approve(address spender, uint256 value) public returns (bool) {
        require(spender != address(0), "Invalid address");
        require(balanceOf[msg.sender] > 0, "invalid baalance");
        Allowance[msg.sender][spender] = value;
        emit Approved(spender, value);
        return (true);
    }

    function transferFrom(
        address spender,
        address sender,
        uint256 amount
    ) public returns (bool) {
        require(spender != address(0), "Invalid address");
        require(balanceOf[sender] > 0, "invalid baalance");
        require(amount > 0, "Invalid amount");
        require(Allowance[sender][spender] >= amount, "");
        balanceOf[sender] -= amount;
        balanceOf[spender] += amount;
        emit Transfer(sender, spender, amount);
        bool isRecipient = false;
        for (uint256 i = 0; i < holders.length; i++) {
            //   address holder = holders[i];
            if (holders[i] == spender) {
                isRecipient = true;
                break;
            }
            if (!isRecipient) {
                holders.push(spender);
            }
        }
        return (true);
    }

    function balance() public view returns (uint256) {
        return (balanceOf[msg.sender]);
    }

    function mint(address account, uint256 amount) public {
        require(account != address(0), "Invalid address");
        require((TotalSupply + amount) >= TotalSupply, "");
        TotalSupply += amount;
        balanceOf[account] += amount;
        emit Mint(account, amount);
    }

    function setTaxAddress(address _Tax) public onlyOnwer {
        taxfee = _Tax;
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) public {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        uint256 senderBalance = balanceOf[sender];
        require(senderBalance >= amount, "not enogh balance");
        bool takeFee = true;
        if (isExcludedfromFee[sender]) {
            takeFee = false;
        }

        if (recipient == pairAddress && takeFee) {
            uint256 TaxFee = amount.mul(devTaxFee).div(1e18);
            uint256 TotalBNBToBePaid = TaxFee.div(holders.length);

            for (uint256 i = 0; i < holders.length; i++) {
                address holder = holders[i];
                require(holder != address(0), "");
                (bool success, ) = payable(holder).call{
                    value: TotalBNBToBePaid
                }("");
                require(success, "BNB transfer to holder failed");
            }
        }
    }
}
