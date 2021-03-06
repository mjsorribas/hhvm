(**
 * Copyright (c) 2015, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the "hack" directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *
 *)

type t = {
 (* When we encounter an unknown class|function|constant name outside
  * of strict mode, is that an error? *)
 tco_assume_php : bool;

 (**
  * Enforces array subtyping relationships.
  *
  * There are a few kinds of arrays in Hack:
  *   1. array: This is a type parameter-less array, that behaves like a PHP
  *      array, but may be used in place of the arrays listed below.
  *   2. array<T>: This is a vector-like array. It may be implemented with a
  *      compact representation. Keys are integer indices. Values are of type T.
  *   3. array<Tk, Tv>: This is a dictionary-like array. It is generally
  *      implemented as a hash table. Keys are of type Tk. Values are of type
  *      Tv.
  *
  * Unfortunately, there is no consistent subtyping relationship between these
  * types:
  *   1. An array<T> may be provided where an array is required.
  *   2. An array may be provided where an array<T> is required.
  *   3. An array<Tk, Tv> may be provided where an array is required.
  *   4. An array may be provided where an array<Tk, Tv> is required.
  *
  * This option enforces a stricter subtyping relationship within these types.
  * In particular, when enabled, points 2. and 4. from the above list become
  * typing errors.
  *)
 tco_safe_array : bool;

 (**
  * Enforces that a vector-like array may not be used where a hashtable-like
  * array is required.
  *
  * When disabled, Hack assumes the following:
  *
  *   array<T> <: array<int, T>
  *
  * When enabled, there is no subtyping relationship between array<T> and
  * array<int, T>.
  *)
 tco_safe_vector_array : bool;

 (* List of <<UserAttribute>> names expected in the codebase *)
 tco_user_attrs : SSet.t option;

 (* Set of experimental features, in lowercase. *)
 tco_experimental_features : SSet.t;

 (* Set of opt-in migration behavior flags, in lowercase. *)
 tco_migration_flags : SSet.t;

 (* Namespace aliasing map *)
 po_auto_namespace_map : (string * string) list;

 (* Should we auto import into the HH namespace? *)
 po_enable_hh_syntax_for_hhvm : bool;

 (* Flag for disabling functions in HHI files with the __PHPStdLib attribute *)
 po_deregister_php_stdlib : bool;

 (**
  * Flag to disallow the definition of destructors unless the
  * __OptionalDestruct attribute is added to the __destruct method.
  *)
 tco_disallow_destruct : bool;

 (*
  * Flag to disalow any lambda that has to be checked using the legacy
  * per-use technique
  *)
 tco_disallow_ambiguous_lambda : bool;

 (*
  * Flag to stop parsing the degenerate ternary ?<whitespace>: as if it
  * were the Elvis operator ?:
  *)
 po_disallow_elvis_space : bool;

 (* Error codes for which we do not allow HH_FIXMEs *)
 ignored_fixme_codes : ISet.t;
}
val make :
  tco_assume_php: bool ->
  tco_safe_array: bool ->
  tco_safe_vector_array: bool ->
  po_deregister_php_stdlib: bool ->
  tco_user_attrs: SSet.t option ->
  tco_experimental_features: SSet.t ->
  tco_migration_flags: SSet.t ->
  po_auto_namespace_map: (string * string) list ->
  tco_disallow_destruct: bool ->
  tco_disallow_ambiguous_lambda: bool ->
  po_disallow_elvis_space: bool ->
  ignored_fixme_codes: ISet.t -> t
val tco_assume_php : t -> bool
val tco_safe_array : t -> bool
val tco_safe_vector_array : t -> bool
val tco_user_attrs : t -> SSet.t option
val tco_experimental_feature_enabled : t -> SSet.elt -> bool
val tco_migration_flag_enabled : t -> SSet.elt -> bool
val tco_allowed_attribute : t -> SSet.elt -> bool
val po_auto_namespace_map : t -> (string * string) list
val po_deregister_php_stdlib : t -> bool
val po_enable_hh_syntax_for_hhvm : t -> bool
val tco_disallow_destruct : t -> bool
val tco_disallow_ambiguous_lambda : t -> bool
val po_disallow_elvis_space : t -> bool
val default : t
val make_permissive : t -> t
val tco_experimental_instanceof : string
val tco_experimental_isarray : string
val tco_experimental_darray_and_varray : string
val tco_experimental_goto : string
val tco_experimental_tconst_on_generics : string
val tco_experimental_disable_shape_and_tuple_arrays : string
val tco_experimental_stronger_shape_idx_ret : string
val tco_experimental_unresolved_fix : string
val tco_experimental_dynamic_types : string
val tco_experimental_generics_arity : string
val tco_experimental_annotate_function_calls : string
val tco_experimental_forbid_nullable_cast : string
val tco_experimental_coroutines: string
val tco_experimental_disallow_static_memoized : string
val tco_experimental_disable_optional_and_unknown_shape_fields : string
val tco_experimental_no_trait_reuse : string
val tco_experimental_is_expression : string
val tco_experimental_no_fallback_in_namespaces : string
val tco_experimental_nonnull : string
val tco_experimental_disallow_untyped_lambda_as_non_function_type : string
val tco_unpacking_check_arity : string
val tco_experimental_disallow_refs_in_array : string
val tco_experimental_all : SSet.t
val tco_migration_flags_all : SSet.t
val ignored_fixme_codes : t -> ISet.t
