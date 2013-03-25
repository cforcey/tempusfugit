Canard::Abilities.for(:timekeeper) do

  can [:manage], Client

  can [:manage], Project

  can [:manage], Span


end