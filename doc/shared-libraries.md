Shared Libraries
================

## mannaconsensus

The purpose of this library is to make the verification functionality that is critical to manna's consensus available to other applications, e.g. to language bindings.

### API

The interface is defined in the C header `mannaconsensus.h` located in  `src/script/mannaconsensus.h`.

#### Version

`mannaconsensus_version` returns an `unsigned int` with the API version *(currently at an experimental `0`)*.

#### Script Validation

`mannaconsensus_verify_script` returns an `int` with the status of the verification. It will be `1` if the input script correctly spends the previous output `scriptPubKey`.

##### Parameters
- `const unsigned char *scriptPubKey` - The previous output script that encumbers spending.
- `unsigned int scriptPubKeyLen` - The number of bytes for the `scriptPubKey`.
- `const unsigned char *txTo` - The transaction with the input that is spending the previous output.
- `unsigned int txToLen` - The number of bytes for the `txTo`.
- `unsigned int nIn` - The index of the input in `txTo` that spends the `scriptPubKey`.
- `unsigned int flags` - The script validation flags *(see below)*.
- `mannaconsensus_error* err` - Will have the error/success code for the operation *(see below)*.

##### Script Flags
- `mannaconsensus_SCRIPT_FLAGS_VERIFY_NONE`
- `mannaconsensus_SCRIPT_FLAGS_VERIFY_P2SH` - Evaluate P2SH ([BIP16](https://github.com/manna/bips/blob/master/bip-0016.mediawiki)) subscripts
- `mannaconsensus_SCRIPT_FLAGS_VERIFY_DERSIG` - Enforce strict DER ([BIP66](https://github.com/manna/bips/blob/master/bip-0066.mediawiki)) compliance
- `mannaconsensus_SCRIPT_FLAGS_VERIFY_NULLDUMMY` - Enforce NULLDUMMY ([BIP147](https://github.com/manna/bips/blob/master/bip-0147.mediawiki))
- `mannaconsensus_SCRIPT_FLAGS_VERIFY_CHECKLOCKTIMEVERIFY` - Enable CHECKLOCKTIMEVERIFY ([BIP65](https://github.com/manna/bips/blob/master/bip-0065.mediawiki))
- `mannaconsensus_SCRIPT_FLAGS_VERIFY_CHECKSEQUENCEVERIFY` - Enable CHECKSEQUENCEVERIFY ([BIP112](https://github.com/manna/bips/blob/master/bip-0112.mediawiki))
- `mannaconsensus_SCRIPT_FLAGS_VERIFY_WITNESS` - Enable WITNESS ([BIP141](https://github.com/manna/bips/blob/master/bip-0141.mediawiki))

##### Errors
- `mannaconsensus_ERR_OK` - No errors with input parameters *(see the return value of `mannaconsensus_verify_script` for the verification status)*
- `mannaconsensus_ERR_TX_INDEX` - An invalid index for `txTo`
- `mannaconsensus_ERR_TX_SIZE_MISMATCH` - `txToLen` did not match with the size of `txTo`
- `mannaconsensus_ERR_DESERIALIZE` - An error deserializing `txTo`
- `mannaconsensus_ERR_AMOUNT_REQUIRED` - Input amount is required if WITNESS is used

### Example Implementations
- [Nmanna](https://github.com/NicolasDorier/Nmanna/blob/master/Nmanna/Script.cs#L814) (.NET Bindings)
- [node-libmannaconsensus](https://github.com/bitpay/node-libmannaconsensus) (Node.js Bindings)
- [java-libmannaconsensus](https://github.com/dexX7/java-libmannaconsensus) (Java Bindings)
- [mannaconsensus-php](https://github.com/Bit-Wasp/mannaconsensus-php) (PHP Bindings)
