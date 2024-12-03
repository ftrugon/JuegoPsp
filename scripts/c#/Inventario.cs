using Godot;
using System.Collections.Generic;

public class Inventory : Node2D
{
	[Export]
	public List<InventoryItem> Items { get; set; } = new List<InventoryItem>();

	private PlayerStatsManager _statsManager;

	public override void _Ready()
	{
		_statsManager = GetParent().GetNode<PlayerStatsManager>("itemsStats");
		ApplyItems(_statsManager.ItemsStats);
	}

	public void ApplyItems(PlayerStats itemsStats)
	{
		foreach (var item in Items)
		{
			item.Aplicar(itemsStats);
		}
	}
}
