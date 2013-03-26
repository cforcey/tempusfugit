Canard::Abilities.for(:admin) do

  can [:manage], User

  can :admin_transaction, :admin_reports
end