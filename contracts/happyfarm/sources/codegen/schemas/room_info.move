module happyfarm::room_info_schema {
	use std::option::some;
    use sui::tx_context::TxContext;
    use sui::table::{Self, Table};
    use happyfarm::events;
    use happyfarm::world::{Self, World};

    // Systems
	friend happyfarm::counter_system;
	friend happyfarm::player_system;

	/// Entity does not exist
	const EEntityDoesNotExist: u64 = 0;

	const SCHEMA_ID: vector<u8> = b"room_info";

	// pos
	// size
	struct RoomInfoData has copy, drop , store {
		pos: vector<u64>,
		size: u8
	}

	public fun new(pos: vector<u64>, size: u8): RoomInfoData {
		RoomInfoData {
			pos, 
			size
		}
	}

	public fun register(_obelisk_world: &mut World, ctx: &mut TxContext) {
		world::add_schema<Table<address,RoomInfoData>>(_obelisk_world, SCHEMA_ID, table::new<address, RoomInfoData>(ctx));
	}

	public(friend) fun set(_obelisk_world: &mut World, _obelisk_entity_key: address,  pos: vector<u64>, size: u8) {
		let _obelisk_schema = world::get_mut_schema<Table<address,RoomInfoData>>(_obelisk_world, SCHEMA_ID);
		let _obelisk_data = new( pos, size);
		if(table::contains<address, RoomInfoData>(_obelisk_schema, _obelisk_entity_key)) {
			*table::borrow_mut<address, RoomInfoData>(_obelisk_schema, _obelisk_entity_key) = _obelisk_data;
		} else {
			table::add(_obelisk_schema, _obelisk_entity_key, _obelisk_data);
		};
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), _obelisk_data)
	}

	public(friend) fun set_pos(_obelisk_world: &mut World, _obelisk_entity_key: address, pos: vector<u64>) {
		let _obelisk_schema = world::get_mut_schema<Table<address,RoomInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, RoomInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, RoomInfoData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.pos = pos;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public(friend) fun set_size(_obelisk_world: &mut World, _obelisk_entity_key: address, size: u8) {
		let _obelisk_schema = world::get_mut_schema<Table<address,RoomInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, RoomInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, RoomInfoData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.size = size;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public fun get(_obelisk_world: &World, _obelisk_entity_key: address): (vector<u64>,u8) {
		let _obelisk_schema = world::get_schema<Table<address,RoomInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, RoomInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, RoomInfoData>(_obelisk_schema, _obelisk_entity_key);
		(
			_obelisk_data.pos,
			_obelisk_data.size
		)
	}

	public fun get_pos(_obelisk_world: &World, _obelisk_entity_key: address): vector<u64> {
		let _obelisk_schema = world::get_schema<Table<address,RoomInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, RoomInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, RoomInfoData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.pos
	}

	public fun get_size(_obelisk_world: &World, _obelisk_entity_key: address): u8 {
		let _obelisk_schema = world::get_schema<Table<address,RoomInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, RoomInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, RoomInfoData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.size
	}

	public(friend) fun remove(_obelisk_world: &mut World, _obelisk_entity_key: address) {
		let _obelisk_schema = world::get_mut_schema<Table<address,RoomInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, RoomInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		table::remove(_obelisk_schema, _obelisk_entity_key);
		events::emit_remove(SCHEMA_ID, _obelisk_entity_key)
	}

	public fun contains(_obelisk_world: &World, _obelisk_entity_key: address): bool {
		let _obelisk_schema = world::get_schema<Table<address,RoomInfoData>>(_obelisk_world, SCHEMA_ID);
		table::contains<address, RoomInfoData>(_obelisk_schema, _obelisk_entity_key)
	}
}
