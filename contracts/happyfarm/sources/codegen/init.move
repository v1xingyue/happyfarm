module happyfarm::init {
    use std::ascii::string;
    use sui::transfer;
    use sui::tx_context::TxContext;
    use happyfarm::world;
	use happyfarm::global_schema;
	use happyfarm::player_info_schema;
	use happyfarm::field_info_schema;
	use happyfarm::plant_schema;
	use happyfarm::plant_attrs_schema;

    fun init(ctx: &mut TxContext) {
        let _obelisk_world = world::create(string(b"Happyfarm"), string(b"Happyfarm"),ctx);

        // Add Schema
		global_schema::register(&mut _obelisk_world, ctx);
		player_info_schema::register(&mut _obelisk_world, ctx);
		field_info_schema::register(&mut _obelisk_world, ctx);
		plant_schema::register(&mut _obelisk_world, ctx);
		plant_attrs_schema::register(&mut _obelisk_world, ctx);

        transfer::public_share_object(_obelisk_world);
    }

    #[test_only]
    public fun init_world_for_testing(ctx: &mut TxContext){
        init(ctx)
    }
}
