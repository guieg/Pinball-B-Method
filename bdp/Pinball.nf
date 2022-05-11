Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(Pinball))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(Pinball))==(Machine(Pinball));
  Level(Machine(Pinball))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(Pinball)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(Pinball))==(?)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(Pinball))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(Pinball))==(?);
  List_Includes(Machine(Pinball))==(?)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(Pinball))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(Pinball))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(Pinball))==(?);
  Context_List_Variables(Machine(Pinball))==(?);
  Abstract_List_Variables(Machine(Pinball))==(?);
  Local_List_Variables(Machine(Pinball))==(?);
  List_Variables(Machine(Pinball))==(?);
  External_List_Variables(Machine(Pinball))==(?)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(Pinball))==(?);
  Abstract_List_VisibleVariables(Machine(Pinball))==(?);
  External_List_VisibleVariables(Machine(Pinball))==(?);
  Expanded_List_VisibleVariables(Machine(Pinball))==(?);
  List_VisibleVariables(Machine(Pinball))==(?);
  Internal_List_VisibleVariables(Machine(Pinball))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(Pinball))==(btrue);
  Gluing_List_Invariant(Machine(Pinball))==(btrue);
  Expanded_List_Invariant(Machine(Pinball))==(btrue);
  Abstract_List_Invariant(Machine(Pinball))==(btrue);
  Context_List_Invariant(Machine(Pinball))==(btrue);
  List_Invariant(Machine(Pinball))==(btrue)
END
&
THEORY ListAssertionsX IS
  Expanded_List_Assertions(Machine(Pinball))==(btrue);
  Abstract_List_Assertions(Machine(Pinball))==(btrue);
  Context_List_Assertions(Machine(Pinball))==(btrue);
  List_Assertions(Machine(Pinball))==(btrue)
END
&
THEORY ListCoverageX IS
  List_Coverage(Machine(Pinball))==(btrue)
END
&
THEORY ListExclusivityX IS
  List_Exclusivity(Machine(Pinball))==(btrue)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(Pinball))==(skip);
  Context_List_Initialisation(Machine(Pinball))==(skip);
  List_Initialisation(Machine(Pinball))==(skip)
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(Pinball))==(?)
END
&
THEORY ListInstanciatedParametersX END
&
THEORY ListConstraintsX IS
  List_Context_Constraints(Machine(Pinball))==(btrue);
  List_Constraints(Machine(Pinball))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(Pinball))==(?);
  List_Operations(Machine(Pinball))==(?)
END
&
THEORY ListInputX END
&
THEORY ListOutputX END
&
THEORY ListHeaderX END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX END
&
THEORY ListSubstitutionX END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(Pinball))==(?);
  Inherited_List_Constants(Machine(Pinball))==(?);
  List_Constants(Machine(Pinball))==(?)
END
&
THEORY ListSetsX IS
  Context_List_Enumerated(Machine(Pinball))==(?);
  Context_List_Defered(Machine(Pinball))==(?);
  Context_List_Sets(Machine(Pinball))==(?);
  List_Valuable_Sets(Machine(Pinball))==(?);
  Inherited_List_Enumerated(Machine(Pinball))==(?);
  Inherited_List_Defered(Machine(Pinball))==(?);
  Inherited_List_Sets(Machine(Pinball))==(?);
  List_Enumerated(Machine(Pinball))==(?);
  List_Defered(Machine(Pinball))==(?);
  List_Sets(Machine(Pinball))==(?)
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(Pinball))==(?);
  Expanded_List_HiddenConstants(Machine(Pinball))==(?);
  List_HiddenConstants(Machine(Pinball))==(?);
  External_List_HiddenConstants(Machine(Pinball))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(Pinball))==(btrue);
  Context_List_Properties(Machine(Pinball))==(btrue);
  Inherited_List_Properties(Machine(Pinball))==(btrue);
  List_Properties(Machine(Pinball))==(btrue)
END
&
THEORY ListSeenInfoX END
&
THEORY ListANYVarX END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(Pinball)) == (? | ? | ? | ? | ? | ? | ? | ? | Pinball);
  List_Of_HiddenCst_Ids(Machine(Pinball)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(Pinball)) == (?);
  List_Of_VisibleVar_Ids(Machine(Pinball)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(Pinball)) == (?: ?)
END
&
THEORY TCIntRdX IS
  predB0 == OK;
  extended_sees == KO;
  B0check_tab == KO;
  local_op == OK;
  abstract_constants_visible_in_values == KO;
  project_type == SOFTWARE_TYPE;
  event_b_deadlockfreeness == KO;
  variant_clause_mandatory == KO;
  event_b_coverage == KO;
  event_b_exclusivity == KO;
  genFeasibilityPO == KO
END
)
