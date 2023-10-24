module happyfarm::player_system {

    use happyfarm::world::World;
    use happyfarm::player_info_schema;
    use happyfarm::global_schema;
    use sui::tx_context::{TxContext,Self};

    public entry fun register(world: &mut World,ctx: &mut TxContext){
        let addr = tx_context::sender(ctx);
        let init_score = global_schema::get_init_user_socre(world);
        player_info_schema::set(world,addr,init_score,true);
    }
}
