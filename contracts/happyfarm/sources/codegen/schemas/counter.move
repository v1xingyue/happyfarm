module happyfarm::counter_schema {
	use std::option::none;
    use sui::tx_context::TxContext;
    use happyfarm::events;
    use happyfarm::world::{Self, World};
    // Systems
	friend happyfarm::counter_system;
	friend happyfarm::player_system;

	const SCHEMA_ID: vector<u8> = b"counter";

	// counter
	// admin
	struct CounterData has copy, drop , store {
		counter: u64,
		admin: address
	}

	public fun new(counter: u64, admin: address): CounterData {
		CounterData {
			counter, 
			admin
		}
	}

	public fun register(_obelisk_world: &mut World, _ctx: &mut TxContext) {
		let _obelisk_schema = new(0,@0x0000000);
		world::add_schema<CounterData>(_obelisk_world, SCHEMA_ID, _obelisk_schema);
		events::emit_set(SCHEMA_ID, none(), _obelisk_schema);
	}

	public(friend) fun set(_obelisk_world: &mut World,  counter: u64, admin: address) {
		let _obelisk_schema = world::get_mut_schema<CounterData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.counter = counter;
		_obelisk_schema.admin = admin;
	}

	public(friend) fun set_counter(_obelisk_world: &mut World, counter: u64) {
		let _obelisk_schema = world::get_mut_schema<CounterData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.counter = counter;
		events::emit_set(SCHEMA_ID, none(), *_obelisk_schema)
	}

	public(friend) fun set_admin(_obelisk_world: &mut World, admin: address) {
		let _obelisk_schema = world::get_mut_schema<CounterData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.admin = admin;
		events::emit_set(SCHEMA_ID, none(), *_obelisk_schema)
	}

	public fun get(_obelisk_world: &World): (u64,address) {
		let _obelisk_schema = world::get_schema<CounterData>(_obelisk_world, SCHEMA_ID);
		(
			_obelisk_schema.counter,
			_obelisk_schema.admin,
		)
	}

	public fun get_counter(_obelisk_world: &World): u64 {
		let _obelisk_schema = world::get_schema<CounterData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.counter
	}

	public fun get_admin(_obelisk_world: &World): address {
		let _obelisk_schema = world::get_schema<CounterData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.admin
	}
}
