## Modular Account Libs

A set of libraries to help build modular smart contract accounts and plugins.

## Installation

### As a Git Submodule in Foundry

```
forge install erc6900/modular-account-libs@v0.7.0
```

Recommended remappings setup:
```plaintext
modular-account-libs/=lib/modular-account-libs/src/
```

### As an NPM package

```
pnpm add github:erc6900/modular-account-libs#v0.7.0
```

Any package manager with NPM support can handle this installation, including `npm`,`yarn`,`pnpm`, and `bun`.

Recommended remappings setup:
```plaintext
modular-account-libs/=node_modules/modular-account-libs/src/
```

## Overview

### Plugin stub contracts

#### BasePlugin

The `BasePlugin` contract implements all necessary functions for a plugin with stub definitions, and acts as a starting point for writing ERC-6900 v0.7 compliant plugin contracts.

All contracts derived from `BasePlugin` should override the functions `pluginManfiest` and `pluginMetadata`.

Depending on the type of plugin being implemented, you may also override additional functions representing validation functions or hooks.

### Libraries

#### LinkedListSetLib and variants

`LinkedListSetLib` implements a “linked list set”, in which elements are held in a mapping from one element to the next. This allows for O(1) _add_, _remove_, and _contains_ operations, while keeping the set values enumerable onchain. This setup requires that the set prevent the addition of duplicate values, prevent addition of a zero value, and maintain a special value designated as the “sentinel” that identifies the start and end of the list. To achieve this, the data size available to the user is reduced to a maximum of a `bytes30`.

In addition to supporting these efficient operations, the library also supports a less-efficient remove operation without knowledge of a predecessor, which traverses the linked list to find the element to remove.

Additionally, entries also support “flags”. These can be thought of as additional values attached to entries, much like a sub-mapping for each element within the set. 14 bits are available for flag values, the lowest two bits are reserved for the sentinel implementation and a list traversal optimization.

`AssociatedLinkedListSetLib` implements a linked list set almost identically to `LinkedListSetLib`, except its entries are held in account-associated storage. This library is intended to be used by plugins, which must hold values in account-associated storage if they wish to access or update them during ERC-4337 validation.

`CountableLinkedListSetLib` extends `LinkedListSetLib` to allow adding a value more than once. It uses the upper byte (8 bits) of the 14 available flag bits for an entry to track this, and supports adding an entry up to 256 times. There does not yet exist a version of this library that is held in associated storage.

The common types and constants used by these libraries are defined in `Constants.sol`.

#### PluginStorageLib

`PluginStorageLib` is a low-level library that provides utilities for getting storage slots in address-associated storage using varying amounts of input data as a key.

#### FunctionReferenceLib

`FunctionReferenceLib` provides helpful conversions and utility functions for using `FunctionReference`, a user-defined value type intended to hold a plugin address and a function id.

### Interfaces

Interfaces defined and depended on by ERC-6900 are available in the `src/interfaces` folder.

## Building and Testing

To build and test the `modular-account-libs` repo, use the following commands.

```bash
# Build options
forge build
FOUNDRY_PROFILE=lite forge build

# Lint
pnpm lint

# Test Options
forge test -vvv
FOUNDRY_PROFILE=lite forge test -vvv
```

## Acknowledgements

The libraries and stub contracts were originally developed in [alchemyplatform/modular-account](https://github.com/alchemyplatform/modular-account/tree/v1.0.1), and are contributed to the ERC-6900 community here. The original library versions, and audits covering the original library versions, can be found in the linked repository.

The files `IERC165` and `ERC165` are ported from @OpenZeppelin/contracts@v5.0.2, made available under the MIT license.

ERC-4337 and ERC-6900 interfaces are released into the public domain via CC0 1.0 Universal as part of the ERC submission process, and made available here.
