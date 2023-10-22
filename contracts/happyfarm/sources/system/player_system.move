module happyfarm::player_system {

    use happyfarm::world::World;
    use happyfarm::player_info_schema;
    use sui::tx_context::{TxContext,Self};

    public entry fun register(world: &mut World,ctx: &mut TxContext){
        let addr = tx_context::sender(ctx);
        player_info_schema::set(world,addr,100,@0x1,true);
    }
}
