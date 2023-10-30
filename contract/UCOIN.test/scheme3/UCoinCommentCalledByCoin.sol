// SPDX-License-Identifier: MIT

// File: contracts/UChildAdministrableERC20.sol

pragma solidity 0.6.12;

contract UCoinCommentByApprove {
    // 这里添加相关的备注代码初始化  coinContract   => from => blockNumber = comment
    mapping(address => mapping(address => mapping(uint256 => string))) private _comments;

    event TransferWithMsg (
        address indexed erc20Contract,
        address indexed from,
        address indexed to,
        uint256 amount,
        string comment
    );

    // 标准，写入存储并扔出event
    function transferWithMsg(address coinContract, address from, address recipient, uint256 amount, string memory comment)
    external
    returns (bool)
    {
        // do msg
        _comments[coinContract][from][block.number] = comment;
        // emit
        emit TransferWithMsg(coinContract, from, recipient, amount, comment);
        return true;
    }

    // 仅扔出event, 不写入存储
    function transferWithMsg2(address coinContract, address from, address recipient, uint256 amount, string memory comment)
    external
    returns (bool)
    {
        // emit
        emit TransferWithMsg(coinContract, from, recipient, amount, comment);
        return true;
    }

    function getComment(address coinContract, address from, uint256 blockNumber) public view returns (string memory) {
        return _comments[coinContract][from][blockNumber];
    }
}