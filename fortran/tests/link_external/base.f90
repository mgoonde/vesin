module base

  use m_neighbour, only: t_neighbour
  implicit none

  !! base type that contains a neighborlist
  type :: t_base
     type( t_neighbour ), pointer :: neigh => null()
  end type t_base

  interface t_base
     procedure :: t_base_constructor
  end interface t_base

contains

  function t_base_constructor()result(self)
    implicit none
    type( t_base ), pointer :: self
    allocate( t_base :: self )
    self% neigh => t_neighbour()
  end function t_base_constructor

end module base
