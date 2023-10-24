module happyfarm::player_info_schema {
	use std::option::some;
    use sui::tx_context::TxContext;
    use sui::table::{Self, Table};
    use happyfarm::events;
    use happyfarm::world::{Self, World};

    // Systems
	friend happyfarm::counter_system;
	friend happyfarm::player_system;
	friend happyfarm::field_system;
	friend happyfarm::plant_system;

	/// Entity does not exist
	const EEntityDoesNotExist: u64 = 0;

	const SCHEMA_ID: vector<u8> = b"player_info";

	// score
	// field
	// register
	struct PlayerInfoData has copy, drop , store {
		score: u64,
		field: u64,
		register: bool
	}

	public fun new(score: u64, field: u64, register: bool): PlayerInfoData {
		PlayerInfoData {
			score, 
			field, 
			register
		}
	}

	public fun register(_obelisk_world: &mut World, ctx: &mut TxContext) {
		world::add_schema<Table<address,PlayerInfoData>>(_obelisk_world, SCHEMA_ID, table::new<address, PlayerInfoData>(ctx));
	}

	public(friend) fun set(_obelisk_world: &mut World, _obelisk_entity_key: address,  score: u64, field: u64, register: bool) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlayerInfoData>>(_obelisk_world, SCHEMA_ID);
		let _obelisk_data = new( score, field, register);
		if(table::contains<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key)) {
			*table::borrow_mut<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key) = _obelisk_data;
		} else {
			table::add(_obelisk_schema, _obelisk_entity_key, _obelisk_data);
		};
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), _obelisk_data)
	}

	public(friend) fun set_score(_obelisk_world: &mut World, _obelisk_entity_key: address, score: u64) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlayerInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.score = score;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public(friend) fun set_field(_obelisk_world: &mut World, _obelisk_entity_key: address, field: u64) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlayerInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.field = field;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public(friend) fun set_register(_obelisk_world: &mut World, _obelisk_entity_key: address, register: bool) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlayerInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.register = register;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public fun get(_obelisk_world: &World, _obelisk_entity_key: address): (u64,u64,bool) {
		let _obelisk_schema = world::get_schema<Table<address,PlayerInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key);
		(
			_obelisk_data.score,
			_obelisk_data.field,
			_obelisk_data.register
		)
	}

	public fun get_score(_obelisk_world: &World, _obelisk_entity_key: address): u64 {
		let _obelisk_schema = world::get_schema<Table<address,PlayerInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.score
	}

	public fun get_field(_obelisk_world: &World, _obelisk_entity_key: address): u64 {
		let _obelisk_schema = world::get_schema<Table<address,PlayerInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.field
	}

	public fun get_register(_obelisk_world: &World, _obelisk_entity_key: address): bool {
		let _obelisk_schema = world::get_schema<Table<address,PlayerInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.register
	}

	public(friend) fun remove(_obelisk_world: &mut World, _obelisk_entity_key: address) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlayerInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		table::remove(_obelisk_schema, _obelisk_entity_key);
		events::emit_remove(SCHEMA_ID, _obelisk_entity_key)
	}

	public fun contains(_obelisk_world: &World, _obelisk_entity_key: address): bool {
		let _obelisk_schema = world::get_schema<Table<address,PlayerInfoData>>(_obelisk_world, SCHEMA_ID);
		table::contains<address, PlayerInfoData>(_obelisk_schema, _obelisk_entity_key)
	}
}
