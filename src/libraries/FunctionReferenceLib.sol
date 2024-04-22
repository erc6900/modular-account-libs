// SPDX-License-Identifier: MIT
//
// See LICENSE-MIT file for more information

pragma solidity ^0.8.20;

import {FunctionReference} from "../interfaces/IPluginManager.sol";

/// @title Function Reference Lib
library FunctionReferenceLib {
    // Empty or unset function reference.
    FunctionReference internal constant EMPTY_FUNCTION_REFERENCE = FunctionReference.wrap(bytes21(0));

    function pack(address addr, uint8 functionId) internal pure returns (FunctionReference) {
        return FunctionReference.wrap(bytes21(bytes20(addr)) | bytes21(uint168(functionId)));
    }

    function unpack(FunctionReference fr) internal pure returns (address addr, uint8 functionId) {
        bytes21 underlying = FunctionReference.unwrap(fr);
        addr = address(bytes20(underlying));
        functionId = uint8(bytes1(underlying << 160));
    }

    function isEmpty(FunctionReference fr) internal pure returns (bool) {
        return FunctionReference.unwrap(fr) == bytes21(0);
    }

    function eq(FunctionReference a, FunctionReference b) internal pure returns (bool) {
        return FunctionReference.unwrap(a) == FunctionReference.unwrap(b);
    }

    function notEq(FunctionReference a, FunctionReference b) internal pure returns (bool) {
        return FunctionReference.unwrap(a) != FunctionReference.unwrap(b);
    }
}
