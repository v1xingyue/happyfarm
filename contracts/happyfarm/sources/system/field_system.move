module happyfarm::field_system {

    use happyfarm::world::World;
    use happyfarm::player_info_schema;
    use happyfarm::field_info_schema;
    use happyfarm::global_schema;
    use happyfarm::entity_key;
    use sui::tx_context::{TxContext,Self};
    

    const E_Score_Not_Enough:u64 = 1001;
    
    public entry fun buy_a_field(world: &mut World,ctx: &mut TxContext){
        
        let field_price = global_schema::get_field_price(world);
        let field_number = global_schema::get_last_field_no(world);
        let addr = tx_context::sender(ctx);
        let (score,_,register) = player_info_schema::get(world,addr);
        assert!(register && score >= field_price,E_Score_Not_Enough);
        let new_score = score - field_price;
        player_info_schema::set_score(world,addr,new_score);
        player_info_schema::set_field(world,addr,field_number);
        
        let field_key = entity_key::from_u256((field_number as u256));
        field_info_schema::set(world,field_key,addr,field_number);

        global_schema::set_last_field_no(world,field_number+1);
    }

}
