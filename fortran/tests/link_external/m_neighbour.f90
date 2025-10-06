module m_neighbour

  ! import the C-interoperable vesin interface
  use vesin_c, only: &
       c_VesinOptions => VesinOptions, &
       c_VesinNeighborList => VesinNeighborList, &
       c_vesin_free => vesin_free

  implicit none


  type :: t_neighbour
     type( c_vesinOptions ) :: opts       !< Computation options
     type( c_vesinNeighborList ) :: cdata !< Returned C data
   contains
     final :: t_neighbour_destroy
  end type t_neighbour

  interface t_neighbour
     procedure :: t_neighbour_constructor
  end interface t_neighbour

contains

  function t_neighbour_constructor()result(self)
    implicit none
    type( t_neighbour ), pointer :: self
    allocate( t_neighbour::self )
  end function t_neighbour_constructor


  subroutine t_neighbour_destroy( self )
    implicit none
    type( t_neighbour ), intent(inout) :: self
    ! make reference to a vesin function
    call c_vesin_free( self%cdata )
  end subroutine t_neighbour_destroy

end module m_neighbour
