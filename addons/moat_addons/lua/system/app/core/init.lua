AddCSLuaFile()

----
-- Need to report a bug? We'd love to talk with you! <3<3<3
-- The best way to contact us is on our (moat.chat) Discord server. (our dm's are open)
----

local sv = SERVER and {
	'system/app/yugh/extensions/server/discord.lua',
	'system/app/yugh/extensions/server/player.lua',
	'system/app/yugh/extensions/color.lua',
	'system/app/yugh/extensions/entity.lua',
	'system/app/yugh/extensions/http.lua',
	'system/app/yugh/extensions/net.lua',
	'system/app/yugh/extensions/player.lua',
	'system/app/yugh/extensions/string.lua',
	'system/app/yugh/extensions/table.lua',
	'system/app/yugh/extensions/timer.lua',
	'system/app/yugh/extensions/type.lua',
	'system/app/yugh/extensions/util.lua',
	'system/app/yugh/modules/comments.lua',
	'system/app/yugh/modules/damage.lua',
	'system/app/yugh/modules/globals.lua',
	'system/app/yugh/modules/helpers.lua',
	'system/app/yugh/modules/servers.lua',
	'autoexec.lua',
	'servers.lua',
	'ranks.lua',
	'superadmin.lua',
	'_dev/init.lua',
	'_dev/realms/shared.lua',
	'system/cfg/init.lua',
	'system/cfg/discord/sv_webhooks.lua',
	'system/cfg/fonts/sv_fonts_fastdl.lua',
	'system/cfg/github/sv_bad_webhooks.lua',
	'system/cfg/maps/sh_blacklist.lua',
	'system/cfg/maps/sh_whitelist.lua',
	'system/cfg/sql/sv_config.lua',
	'system/cfg/tests/sv_basehealth.lua',
	'system/app/app_mt.lua',
	'system/app/include.lua',
	'system/app/ttt/init.lua',
	'system/app/ttt/core/sh_rounds.lua',
	'system/app/ttt/core/sv_controls.lua',
	'system/app/ttt/core/sv_player.lua',
	'system/app/ttt/app.lua',
	'system/app/ttt/detours/sv_misc.lua',
	'system/app/ttt/detours/sv_rounds.lua',
	'system/app/ux/init_sv.lua',
	'system/app/ux/core/palette.lua',
	'system/app/ux/defaults/include_sh.lua',
	'system/app/core/detours/server/net.lua',
	'system/app/core/helpers/sh_tables.lua',
	'datastore.lua',
	'plugins/init.lua',
	'plugins/assets/models_npcs.lua',
	'plugins/assets/weapon_sounds.lua',
	'plugins/crashscreen/init_sh.lua',
	'plugins/crashscreen/main_sv.lua',
	'plugins/logs/damagelogs/init.lua',
	'plugins/logs/damagelogs/init/sh_chat.lua',
	'plugins/logs/damagelogs/init/sh_notify.lua',
	'plugins/logs/damagelogs/init/sh_rdm_manager.lua',
	'plugins/logs/damagelogs/init/sh_weapontable.lua',
	'plugins/logs/damagelogs/utils/sh_orderedpairs.lua',
	'plugins/logs/damagelogs/server/sv_autoslay.lua',
	'plugins/logs/damagelogs/server/sv_chat.lua',
	'plugins/logs/damagelogs/server/sv_damageinfos.lua',
	'plugins/logs/damagelogs/server/sv_damagelog.lua',
	'plugins/logs/damagelogs/server/sv_rdm_manager.lua',
	'plugins/logs/damagelogs/server/sv_recording.lua',
	'plugins/logs/damagelogs/server/sv_stupidoverrides.lua',
	'plugins/logs/damagelogs/server/sv_weapontable.lua',
	'plugins/logs/damagelogs/server/included/sv_oldlogs.lua',
	'plugins/logs/damagelogs/shared/sh_autoslay.lua',
	'plugins/logs/damagelogs/shared/sh_events.lua',
	'plugins/logs/damagelogs/shared/sh_notify.lua',
	'plugins/logs/damagelogs/shared/sh_privileges.lua',
	'plugins/logs/damagelogs/shared/sh_sync_entity.lua',
	-- 'plugins/logs/mlogs/init.lua',
	-- 'plugins/logs/mlogs/utils.lua',
	-- 'plugins/logs/mlogs/utils/draw.lua',
	-- 'plugins/logs/mlogs/utils/funcs.lua',
	-- 'plugins/logs/mlogs/utils/lang.lua',
	-- 'plugins/logs/mlogs/utils/meta.lua',
	-- 'plugins/logs/mlogs/utils/sv_net.lua',
	-- 'plugins/logs/mlogs/server/init.lua',
	-- 'plugins/logs/mlogs/server/autoslay.lua',
	-- 'plugins/logs/mlogs/server/chat.lua',
	-- 'plugins/logs/mlogs/server/events.lua',
	-- 'plugins/logs/mlogs/server/hooks.lua',
	-- 'plugins/logs/mlogs/server/maps.lua',
	-- 'plugins/logs/mlogs/server/players.lua',
	-- 'plugins/logs/mlogs/server/rounds.lua',
	-- 'plugins/logs/mlogs/server/servers.lua',
	-- 'plugins/logs/mlogs/server/sql.lua',
	-- 'plugins/logs/mlogs/server/weps.lua',
	-- 'plugins/logs/mlogs/server/witness.lua',
	-- 'plugins/logs/mlogs/server/mysql/sql_mysqloo.lua',
	-- 'plugins/logs/mlogs/shared/sh_event.lua',
	-- 'plugins/logs/mlogs/shared/sh_format.lua',
	-- 'plugins/logs/mlogs/shared/events/events.lua',
	-- 'plugins/logs/mlogs/shared/events/hooks/sv_slay.lua',
	-- 'plugins/logs/mlogs/shared/events/hooks/sv_switch.lua',
	-- 'plugins/logs/mlogs/shared/events/hooks/sv_used.lua',
	'plugins/mapvote/init.lua',
	'plugins/mapvote/core/sv_mapvote.lua',
	'plugins/mapvote/prevent/init.lua',
	'plugins/mapvote/prevent/sv_check.lua',
	'plugins/mapvote/prevent/sv_switch.lua',
	'plugins/mapvote/voting/sv_autovote.lua',
	'plugins/mapvote/voting/sv_rtv.lua',
	'plugins/minigames/init.lua',
	'plugins/moat/init.lua',
	'plugins/moat/init/sh_ranks.lua',
	'plugins/moat/dev_stuff/sv_ammo.lua',
	'plugins/moat/dev_stuff/sv_hype_crate.lua',
	'plugins/moat/dev_stuff/sv_string_testing_shit.lua',
	'plugins/moat/modules/utils/sv_holster.lua',
	'plugins/moat/modules/anticheat/server/mac.lua',
	'plugins/moat/modules/anticrash/sv_moat_crashcatcher.lua',
	'plugins/moat/modules/automod/sv_teamkills.lua',
	'plugins/moat/modules/battlepass/ignore.lua',
	'plugins/moat/modules/battlepass/sv_battlepass.lua',
	'plugins/moat/modules/battlepass/sh_battlepass.lua',
	'plugins/moat/modules/bhop/moat_bunny_hop.lua',
	'plugins/moat/modules/chat/sh_chat_util.lua',
	'plugins/moat/modules/chat/sv_adverts.lua',
	'plugins/moat/modules/chat/sv_chat.lua',
	'plugins/moat/modules/chat/sv_logger.lua',
	'plugins/moat/modules/cheats/sv_ic.lua',
	'plugins/moat/modules/deathmsgs/chatmsg/sv_drowning.lua',
	'plugins/moat/modules/deathmsgs/chatmsg/sv_notify.lua',
	'plugins/moat/modules/deathmsgs/killcards/sv_killcard.lua',
	'plugins/moat/modules/detours/sh_networkvar.lua',
	'plugins/moat/modules/discord/sv_discord.lua',
	'plugins/moat/modules/discord/sv_error_catcher.lua',
	'plugins/moat/modules/discord/sv_staffcmds.lua',
	'plugins/moat/modules/discord/relay/utils/sh_discordcolors.lua',
	'plugins/moat/modules/discord/relay/server/sv_relay.lua',
	'plugins/moat/modules/donate/sv_moat_donate.lua',
	'plugins/moat/modules/donate/sv_moat_limited.lua',
	'plugins/moat/modules/duckhop/sh_duckhop.lua',
	'plugins/moat/modules/hit/init.lua',
	'plugins/moat/modules/hit/sv_ahr.lua',
	'plugins/moat/modules/inv2/init.lua',
	'plugins/moat/modules/inv2/utils.lua',
	'plugins/moat/modules/inv2/utils/item.lua',
	'plugins/moat/modules/inv2/utils/items_rarity.lua',
	'plugins/moat/modules/inv2/utils/items_stat.lua',
	'plugins/moat/modules/inv2/utils/items_talent.lua',
	'plugins/moat/modules/inv2/utils/text_effects.lua',
	'plugins/moat/modules/inv2/utils/weapons.lua',
	'plugins/moat/modules/inv2/utils/sql/ignore.lua',
	'plugins/moat/modules/inv2/utils/status/sv_baseeffect.lua',
	'plugins/moat/modules/inv2/utils/status/sv_basestatus.lua',
	'plugins/moat/modules/inv2/utils/status/sv_status.lua',
	'plugins/moat/modules/inv2/server/sv_crates.lua',
	'plugins/moat/modules/inv2/server/sv_inv.lua',
	'plugins/moat/modules/inv2/server/sv_invs_net.lua',
	'plugins/moat/modules/inv2/server/sv_invs_sql.lua',
	'plugins/moat/modules/inv2/server/sv_items_comps.lua',
	'plugins/moat/modules/inv2/server/sv_items_drops.lua',
	'plugins/moat/modules/inv2/server/sv_items_gifts.lua',
	'plugins/moat/modules/inv2/server/sv_items_random.lua',
	'plugins/moat/modules/inv2/server/sv_items_saved.lua',
	'plugins/moat/modules/inv2/server/sv_items_talents.lua',
	'plugins/moat/modules/inv2/server/sv_loadout.lua',
	'plugins/moat/modules/inv2/server/sv_loadouts_powerups.lua',
	'plugins/moat/modules/inv2/server/sv_tabs_bounties.lua',
	'plugins/moat/modules/inv2/server/sv_tabs_games.lua',
	'plugins/moat/modules/inv2/server/sv_tabs_shop.lua',
	'plugins/moat/modules/inv2/server/sv_tabs_stats.lua',
	'plugins/moat/modules/inv2/server/sv_trades_bans.lua',
	'plugins/moat/modules/inv2/server/sv_trades_logs.lua',
	'plugins/moat/modules/inv2/server/sv_weps_range.lua',
	'plugins/moat/modules/inv2/shared/sh_anims.lua',
	'plugins/moat/modules/inv2/shared/sh_invs.lua',
	'plugins/moat/modules/inv2/shared/sh_items.lua',
	'plugins/moat/modules/inv2/shared/sh_omegas.lua',
	'plugins/moat/modules/inv2/shared/sh_mods.lua',
	'plugins/moat/modules/inv2/shared/sh_taunts.lua',
	'plugins/moat/modules/inv2/shared/sh_usables.lua',
	'plugins/moat/modules/inv2/shared/sh_talents.lua',
	'plugins/moat/modules/inv2/ass/very_old_rarities.lua',
	'plugins/moat/modules/inv2/ass/paints/sh_testskin.lua',
	'plugins/moat/modules/inv2/ass/seasonal/easter/sv_easterboss.lua',
	'plugins/moat/modules/inv2/ass/seasonal/easter/sv_moateaster.lua',
	'plugins/moat/modules/inv2/ass/seasonal/halloween/sv_moat_halloween.lua',
	'plugins/moat/modules/inv2/server/sv_tabs_event.lua',
	'plugins/moat/modules/inv2/data/collect_dev.lua',
	'plugins/moat/modules/inv2/data/enums.lua',
	'plugins/moat/modules/inv2/data/rarities.lua',
	'plugins/moat/modules/inv2/data/stats.lua',
	'plugins/moat/modules/inv2/data/talents.lua',
	'plugins/moat/modules/inv2/data/weapons.lua',
	'plugins/d3a/init.lua',
	'plugins/d3a/server/sv_bans.lua',
	'plugins/d3a/server/sv_chat.lua',
	'plugins/d3a/server/sv_commands.lua',
	'plugins/d3a/server/sv_map.lua',
	'plugins/d3a/server/sv_player.lua',
	'plugins/d3a/server/sv_player_checkpass.lua',
	'plugins/d3a/server/sv_player_extension.lua',
	'plugins/d3a/server/sv_player_karma.lua',
	'plugins/d3a/server/sv_ranks.lua',
	'plugins/d3a/server/sv_time.lua',
	'plugins/d3a/server/sv_vote.lua',
	'plugins/d3a/server/sv_warns.lua',
	'plugins/d3a/shared/sh_nw.lua',
	'plugins/d3a/shared/sh_nwvars.lua',
	'plugins/d3a/shared/sh_player_extension.lua',
	'plugins/d3a/shared/sh_tblmaker.lua',
	'plugins/d3a/util.lua',
	'plugins/moat/modules/latency/sv_lowlatency.lua',
	'plugins/moat/modules/raffles/sh_raffles.lua',
	'plugins/moat/modules/raffles/sv_giveaway.lua',
	'plugins/moat/modules/resources/mats.lua',
	'plugins/moat/modules/resources/sv_dl.lua',
	'plugins/moat/modules/rewards/forums/sv_moat_forums.lua',
	'plugins/moat/modules/rewards/steam/sv_moat_steam.lua',
	'plugins/moat/modules/rounds/minigames/sh_damage.lua',
	'plugins/moat/modules/rounds/wacky/sv_wacky.lua',
	'plugins/moat/modules/scoreboard/levels/sv_level_color.lua',
	'plugins/moat/modules/scoreboard/titles/sv_moat_titles.lua',
	'plugins/moat/modules/sessions/sv_players.lua',
	'plugins/moat/modules/sessions/sv_servers.lua',
	'plugins/moat/modules/snap/init.lua',
	'plugins/moat/modules/snap/utils.lua',
	'plugins/moat/modules/snap/server/server.lua',
	'plugins/moat/modules/snow/sv_snow.lua',
	'plugins/moat/modules/staffrewards/sv_reward.lua',
	'plugins/moat/modules/terrortown/hs_sound_sv.lua',
	'plugins/moat/modules/terrortown/post_music_sv.lua',
	'plugins/moat/modules/terrortown/sv_antiprop_prep.lua',
	'plugins/moat/modules/terrortown/sv_boom_body.lua',
	'plugins/moat/modules/terrortown/sv_buddy_damage.lua',
	'plugins/moat/modules/terrortown/sv_fix_maps.lua',
	'plugins/moat/modules/terrortown/sv_moat_disguiser.lua',
	'plugins/moat/modules/terrortown/sv_ragdoll_recreate.lua',
	'plugins/moat/modules/tracers/sh_init.lua',
	'plugins/moat/modules/validspawns/sv_spawns.lua',
	'plugins/moat/modules/weapons/server/sv_alt_detector.lua',
	'plugins/moat/modules/weapons/sh_vm.lua',
	'plugins/mse/init.lua',
	'plugins/mse/server/sv_events.lua',
	'plugins/mse/server/sv_ranks.lua',
	'plugins/mse/shared/sh_cmds.lua',
	'plugins/mse/util.lua',
	'plugins/staff/sv_track.lua',
	'plugins/staff/sv_ui.lua',
	'plugins/vphysics-airbag/server/init.lua',
	'plugins/vphysics-airbag/server/entity.lua',
	'plugins/vphysics-airbag/server/enumerator.lua',
	'plugins/vphysics-airbag/server/math.lua',
	'plugins/vphysics-airbag/server/physobj.lua',
	'plugins/vphysics-airbag/server/ragdolls.lua',
	'plugins/weapons/terrortown/sh_biohazardball_config.lua',
	'plugins/weapons/terrortown/sh_rsb_config.lua',
	'plugins/weapons/terrortown/sv_portable_tester.lua',
	'plugins/weapons/vapes/sh_vapeswep.lua',
	'plugins/weapons/vapes/sv_vapeswep.lua',
} or {}

local cl = {
	'system/app/yugh/extensions/client/derma.lua',
	'system/app/yugh/extensions/client/globals.lua',
	'system/app/yugh/extensions/client/player.lua',
	'system/app/yugh/extensions/client/surface.lua',
	'system/app/yugh/extensions/color.lua',
	'system/app/yugh/extensions/entity.lua',
	'system/app/yugh/extensions/http.lua',
	'system/app/yugh/extensions/net.lua',
	'system/app/yugh/extensions/player.lua',
	'system/app/yugh/extensions/string.lua',
	'system/app/yugh/extensions/table.lua',
	'system/app/yugh/extensions/timer.lua',
	'system/app/yugh/extensions/type.lua',
	'system/app/yugh/extensions/util.lua',
	'system/app/yugh/modules/comments.lua',
	'system/app/yugh/modules/damage.lua',
	'system/app/yugh/modules/globals.lua',
	'system/app/yugh/modules/helpers.lua',
	'system/app/yugh/modules/servers.lua',
	'autoexec.lua',
	'servers.lua',
	'ranks.lua',
	'superadmin.lua',
	'_dev/init.lua',
	'_dev/realms/client.lua',
	'_dev/realms/shared.lua',
	'system/cfg/init.lua',
	'system/cfg/fonts/cl_fonts.lua',
	'system/cfg/maps/sh_blacklist.lua',
	'system/cfg/maps/sh_whitelist.lua',
	'system/cfg/ux/resolutions.lua',
	'system/app/app_mt.lua',
	'system/app/include.lua',
	'system/app/ttt/init.lua',
	'system/app/ttt/core/sh_rounds.lua',
	'system/app/ttt/app.lua',
	'system/app/ttt/interface/tttradialmenu.lua',
	'system/app/ux/init_cl.lua',
	'system/app/ux/utils/scale.lua',
	'system/app/ux/utils/tools.lua',
	'system/app/ux/core/fonts.lua',
	'system/app/ux/core/mats.lua',
	'system/app/ux/core/palette.lua',
	'system/app/ux/core/queue.lua',
	'system/app/ux/app.lua',
	'system/app/ux/defaults/include_sh.lua',
	'system/app/ux/elements/frames.lua',
	'system/app/ux/elements/shapes.lua',
	'system/app/ux/themes/default/include.lua',
	'system/app/core/helpers/cl_sfx.lua',
	'system/app/core/helpers/sh_tables.lua',
	'plugins/init.lua',
	'plugins/assets/models_npcs.lua',
	'plugins/assets/weapon_sounds.lua',
	'plugins/crashscreen/init_sh.lua',
	'plugins/crashscreen/utils/cl_chat.lua',
	'plugins/crashscreen/utils/cl_menu.lua',
	'plugins/crashscreen/utils/cl_misc.lua',
	'plugins/crashscreen/utils/cl_web.lua',
	'plugins/crashscreen/main_cl.lua',
	'plugins/d3a/init.lua',
	'plugins/d3a/client/cl_block.lua',
	'plugins/d3a/client/cl_chat.lua',
	'plugins/d3a/client/cl_menu.lua',
	'plugins/d3a/client/cl_motd.lua',
	'plugins/d3a/client/cl_player.lua',
	'plugins/d3a/client/cl_vote.lua',
	'plugins/d3a/client/cl_warns.lua',
	'plugins/d3a/shared/sh_nw.lua',
	'plugins/d3a/shared/sh_nwvars.lua',
	'plugins/d3a/shared/sh_player_extension.lua',
	'plugins/d3a/util.lua',
	'plugins/d3a/shared/sh_tblmaker.lua',
	'plugins/logs/damagelogs/init.lua',
	'plugins/logs/damagelogs/init/sh_chat.lua',
	'plugins/logs/damagelogs/init/sh_notify.lua',
	'plugins/logs/damagelogs/init/sh_rdm_manager.lua',
	'plugins/logs/damagelogs/init/sh_weapontable.lua',
	'plugins/logs/damagelogs/utils/cl_base64decode.lua',
	'plugins/logs/damagelogs/utils/cl_drawcircle.lua',
	'plugins/logs/damagelogs/utils/sh_orderedpairs.lua',
	'plugins/logs/damagelogs/utils/cl_tabs/damagetab.lua',
	'plugins/logs/damagelogs/utils/cl_tabs/old_logs.lua',
	'plugins/logs/damagelogs/utils/cl_tabs/rdm_manager.lua',
	'plugins/logs/damagelogs/utils/cl_tabs/settings.lua',
	'plugins/logs/damagelogs/utils/cl_tabs/shoots.lua',
	'plugins/logs/damagelogs/client/cl_chat.lua',
	'plugins/logs/damagelogs/client/cl_colors.lua',
	'plugins/logs/damagelogs/client/cl_damagelog.lua',
	'plugins/logs/damagelogs/client/cl_filters.lua',
	'plugins/logs/damagelogs/client/cl_infolabel.lua',
	'plugins/logs/damagelogs/client/cl_listview.lua',
	'plugins/logs/damagelogs/client/cl_rdm_manager.lua',
	'plugins/logs/damagelogs/client/cl_recording.lua',
	'plugins/logs/damagelogs/client/cl_ttt_settings.lua',
	'plugins/logs/damagelogs/shared/sh_autoslay.lua',
	'plugins/logs/damagelogs/shared/sh_events.lua',
	'plugins/logs/damagelogs/shared/sh_notify.lua',
	'plugins/logs/damagelogs/shared/sh_privileges.lua',
	'plugins/logs/damagelogs/shared/sh_sync_entity.lua',
	-- 'plugins/logs/mlogs/init.lua',
	-- 'plugins/logs/mlogs/utils.lua',
	-- 'plugins/logs/mlogs/utils/draw.lua',
	-- 'plugins/logs/mlogs/utils/funcs.lua',
	-- 'plugins/logs/mlogs/utils/lang.lua',
	-- 'plugins/logs/mlogs/utils/meta.lua',
	-- 'plugins/logs/mlogs/client/net.lua',
	-- 'plugins/logs/mlogs/client/chat/cl_chat.lua',
	-- 'plugins/logs/mlogs/shared/sh_event.lua',
	-- 'plugins/logs/mlogs/shared/sh_format.lua',
	-- 'plugins/logs/mlogs/shared/events/events.lua',
	-- 'plugins/logs/mlogs/ux/ui.lua',
	'plugins/mapvote/init.lua',
	'plugins/mapvote/core/cl_mapvote.lua',
	'plugins/mapvote/prevent/init.lua',
	'plugins/minigames/init.lua',
	'plugins/moat/init.lua',
	'plugins/moat/init/cl_texteffects.lua',
	'plugins/moat/init/cl_util.lua',
	'plugins/moat/init/sh_ranks.lua',
	'plugins/moat/modules/anticheat/client/mac.lua',
	'plugins/moat/modules/battlepass/ignore.lua',
	'plugins/moat/modules/battlepass/cl_battlepass.lua',
	'plugins/moat/modules/battlepass/sh_battlepass.lua',
	'plugins/moat/modules/bhop/moat_bunny_hop.lua',
	'plugins/moat/modules/chat/cl_chat.lua',
	'plugins/moat/modules/chat/cl_hook.lua',
	'plugins/moat/modules/chat/sh_chat_util.lua',
	'plugins/moat/modules/deathmsgs/chatmsg/cl_notify.lua',
	'plugins/moat/modules/deathmsgs/killcards/cl_killcard.lua',
	'plugins/moat/modules/detours/sh_networkvar.lua',
	'plugins/moat/modules/discord/cl_discord.lua',
	'plugins/moat/modules/discord/relay/utils/sh_discordcolors.lua',
	'plugins/moat/modules/donate/cl_moat_donate.lua',
	'plugins/moat/modules/duckhop/sh_duckhop.lua',
	'plugins/moat/modules/emojilib/cl_emojilib.lua',
	'plugins/moat/modules/fps/cl_shadows.lua',
	'plugins/moat/modules/gwen/cl_dbutton.lua',
	'plugins/moat/modules/gwen/cl_moat_skin.lua',
	'plugins/moat/modules/hit/init.lua',
	'plugins/moat/modules/hit/cl_ahr.lua',
	'plugins/moat/modules/hud/cl_hud.lua',
	'plugins/moat/modules/idle/cl_moat_idle.lua',
	'plugins/moat/modules/inv2/init.lua',
	'plugins/moat/modules/inv2/utils.lua',
	'plugins/moat/modules/inv2/utils/item.lua',
	'plugins/moat/modules/inv2/utils/items_rarity.lua',
	'plugins/moat/modules/inv2/utils/items_stat.lua',
	'plugins/moat/modules/inv2/utils/items_talent.lua',
	'plugins/moat/modules/inv2/utils/text_effects.lua',
	'plugins/moat/modules/inv2/utils/weapons.lua',
	'plugins/moat/modules/inv2/utils/sql/ignore.lua',
	'plugins/moat/modules/inv2/utils/status/cl_status.lua',
	'plugins/moat/modules/inv2/client/cl_chat.lua',
	'plugins/moat/modules/inv2/client/cl_comps.lua',
	'plugins/moat/modules/inv2/client/cl_crate.lua',
	'plugins/moat/modules/inv2/client/cl_gifts.lua',
	'plugins/moat/modules/inv2/client/cl_inspect.lua',
	'plugins/moat/modules/inv2/client/cl_inv.lua',
	'plugins/moat/modules/inv2/client/cl_invs_backend.lua',
	'plugins/moat/modules/inv2/client/cl_invs_custompos.lua',
	'plugins/moat/modules/inv2/client/cl_invs_iconpos.lua',
	'plugins/moat/modules/inv2/client/cl_invs_loadouts.lua',
	'plugins/moat/modules/inv2/client/cl_invs_net.lua',
	'plugins/moat/modules/inv2/client/cl_invs_trades.lua',
	'plugins/moat/modules/inv2/client/cl_invs_usable.lua',
	'plugins/moat/modules/inv2/client/cl_tabs_bounties.lua',
	'plugins/moat/modules/inv2/client/cl_tabs_games.lua',
	'plugins/moat/modules/inv2/client/cl_tabs_settings.lua',
	'plugins/moat/modules/inv2/client/cl_tabs_shop.lua',
	'plugins/moat/modules/inv2/client/cl_tabs_stats.lua',
	'plugins/moat/modules/inv2/shared/sh_anims.lua',
	'plugins/moat/modules/inv2/shared/sh_invs.lua',
	'plugins/moat/modules/inv2/shared/sh_items.lua',
	'plugins/moat/modules/inv2/shared/sh_omegas.lua',
	'plugins/moat/modules/inv2/shared/sh_mods.lua',
	'plugins/moat/modules/inv2/shared/sh_taunts.lua',
	'plugins/moat/modules/inv2/shared/sh_usables.lua',
	'plugins/moat/modules/inv2/shared/sh_talents.lua',
	'plugins/moat/modules/inv2/ass/very_old_rarities.lua',
	'plugins/moat/modules/inv2/ass/paints/sh_testskin.lua',
	'plugins/moat/modules/inv2/ass/seasonal/easter/cl_moateaster.lua',
	'plugins/moat/modules/inv2/ass/seasonal/easter_giveaway/cl_easterdrop.lua',
	'plugins/moat/modules/inv2/ass/seasonal/halloween/cl_moat_halloween.lua',
	'plugins/moat/modules/inv2/client/cl_tabs_event.lua',
	'plugins/moat/modules/inv2/data/collect_dev.lua',
	'plugins/moat/modules/inv2/data/enums.lua',
	'plugins/moat/modules/inv2/data/rarities.lua',
	'plugins/moat/modules/inv2/data/stats.lua',
	'plugins/moat/modules/inv2/data/talents.lua',
	'plugins/moat/modules/inv2/data/weapons.lua',
	'plugins/moat/modules/inv2/ux/inventory/blur.lua',
	'plugins/moat/modules/inv2/ux/inventory/themes.lua',
	'plugins/moat/modules/raffles/sh_raffles.lua',
	'plugins/moat/modules/resources/cl_dl.lua',
	'plugins/moat/modules/resources/mats.lua',
	'plugins/moat/modules/rewards/forums/cl_moat_forums.lua',
	'plugins/moat/modules/rewards/steam/cl_moat_steam.lua',
	'plugins/moat/modules/rounds/minigames/sh_damage.lua',
	'plugins/moat/modules/rounds/wacky/cl_wacky.lua',
	'plugins/moat/modules/scoreboard/cl_moat_scoreboard.lua',
	'plugins/moat/modules/scoreboard/levels/cl_level_color.lua',
	'plugins/moat/modules/scoreboard/titles/cl_moat_titles.lua',
	'plugins/moat/modules/settings/cl_binds.lua',
	'plugins/moat/modules/settings/cl_eqmenu.lua',
	'plugins/moat/modules/settings/cl_help.lua',
	'plugins/moat/modules/snap/init.lua',
	'plugins/moat/modules/snap/utils.lua',
	'plugins/moat/modules/snap/client/client.lua',
	'plugins/moat/modules/snap/client/menu.lua',
	'plugins/moat/modules/snow/cl_snow.lua',
	'plugins/moat/modules/spawn/cl_new.lua',
	'plugins/moat/modules/terrortown/hs_sound_cl.lua',
	'plugins/moat/modules/terrortown/post_music_cl.lua',
	'plugins/moat/modules/tracers/sh_init.lua',
	'plugins/moat/modules/weapons/client/cl_weps.lua',
	'plugins/moat/modules/weapons/sh_vm.lua',
	'plugins/mse/init.lua',
	'plugins/mse/client/cl_menu.lua',
	'plugins/mse/client/cl_net.lua',
	'plugins/mse/shared/sh_cmds.lua',
	'plugins/mse/util.lua',
	'plugins/staff/cl_multislider.lua',
	'plugins/staff/cl_ui.lua',
	'plugins/weapons/terrortown/sh_biohazardball_config.lua',
	'plugins/weapons/terrortown/sh_rsb_config.lua',
	'plugins/weapons/vapes/cl_vapeswep.lua',
	'plugins/weapons/vapes/sh_vapeswep.lua',
}

local sh = {
	['system/app/yugh/extensions/color.lua'] = true,
	['system/app/yugh/extensions/entity.lua'] = true,
	['system/app/yugh/extensions/http.lua'] = true,
	['system/app/yugh/extensions/net.lua'] = true,
	['system/app/yugh/extensions/player.lua'] = true,
	['system/app/yugh/extensions/string.lua'] = true,
	['system/app/yugh/extensions/table.lua'] = true,
	['system/app/yugh/extensions/timer.lua'] = true,
	['system/app/yugh/extensions/type.lua'] = true,
	['system/app/yugh/extensions/util.lua'] = true,
	['system/app/yugh/modules/comments.lua'] = true,
	['system/app/yugh/modules/damage.lua'] = true,
	['system/app/yugh/modules/globals.lua'] = true,
	['system/app/yugh/modules/helpers.lua'] = true,
	['system/app/yugh/modules/servers.lua'] = true,
	['autoexec.lua'] = true,
	['servers.lua'] = true,
	['ranks.lua'] = true,
	['superadmin.lua'] = true,
	['_dev/init.lua'] = true,
	['_dev/realms/shared.lua'] = true,
	['system/cfg/init.lua'] = true,
	['system/cfg/maps/sh_blacklist.lua'] = true,
	['system/cfg/maps/sh_whitelist.lua'] = true,
	['system/app/include.lua'] = true,
	['system/app/app_mt.lua'] = true,
	['system/app/ttt/init.lua'] = true,
	['system/app/ttt/core/sh_rounds.lua'] = true,
	['system/app/ttt/app.lua'] = true,
	['system/app/ux/core/palette.lua'] = true,
	['system/app/ux/defaults/include_sh.lua'] = true,
	['system/app/core/helpers/sh_tables.lua'] = true,
	['plugins/init.lua'] = true,
	['plugins/assets/models_npcs.lua'] = true,
	['plugins/assets/weapon_sounds.lua'] = true,
	['plugins/crashscreen/init_sh.lua'] = true,
	['plugins/d3a/init.lua'] = true,
	['plugins/d3a/shared/sh_nw.lua'] = true,
	['plugins/d3a/shared/sh_nwvars.lua'] = true,
	['plugins/d3a/shared/sh_player_extension.lua'] = true,
	['plugins/d3a/util.lua'] = true,
	['plugins/d3a/shared/sh_tblmaker.lua'] = true,
	['plugins/logs/damagelogs/init.lua'] = true,
	['plugins/logs/damagelogs/init/sh_chat.lua'] = true,
	['plugins/logs/damagelogs/init/sh_notify.lua'] = true,
	['plugins/logs/damagelogs/init/sh_rdm_manager.lua'] = true,
	['plugins/logs/damagelogs/init/sh_weapontable.lua'] = true,
	['plugins/logs/damagelogs/utils/sh_orderedpairs.lua'] = true,
	['plugins/logs/damagelogs/shared/sh_autoslay.lua'] = true,
	['plugins/logs/damagelogs/shared/sh_events.lua'] = true,
	['plugins/logs/damagelogs/shared/sh_notify.lua'] = true,
	['plugins/logs/damagelogs/shared/sh_privileges.lua'] = true,
	['plugins/logs/damagelogs/shared/sh_sync_entity.lua'] = true,
	-- ['plugins/logs/mlogs/init.lua'] = true,
	-- ['plugins/logs/mlogs/utils.lua'] = true,
	-- ['plugins/logs/mlogs/utils/draw.lua'] = true,
	-- ['plugins/logs/mlogs/utils/funcs.lua'] = true,
	-- ['plugins/logs/mlogs/utils/lang.lua'] = true,
	-- ['plugins/logs/mlogs/utils/meta.lua'] = true,
	-- ['plugins/logs/mlogs/shared/sh_event.lua'] = true,
	-- ['plugins/logs/mlogs/shared/sh_format.lua'] = true,
	-- ['plugins/logs/mlogs/shared/events/events.lua'] = true,
	['plugins/mapvote/init.lua'] = true,
	['plugins/mapvote/prevent/init.lua'] = true,
	['plugins/minigames/init.lua'] = true,
	['plugins/moat/init.lua'] = true,
	['plugins/moat/init/sh_ranks.lua'] = true,
	['plugins/moat/modules/battlepass/ignore.lua'] = true,
	['plugins/moat/modules/bhop/moat_bunny_hop.lua'] = true,
	['plugins/moat/modules/chat/sh_chat_util.lua'] = true,
	['plugins/moat/modules/detours/sh_networkvar.lua'] = true,
	['plugins/moat/modules/discord/relay/utils/sh_discordcolors.lua'] = true,
	['plugins/moat/modules/duckhop/sh_duckhop.lua'] = true,
	['plugins/moat/modules/hit/init.lua'] = true,
	['plugins/moat/modules/inv2/init.lua'] = true,
	['plugins/moat/modules/inv2/utils.lua'] = true,
	['plugins/moat/modules/inv2/utils/item.lua'] = true,
	['plugins/moat/modules/inv2/utils/items_rarity.lua'] = true,
	['plugins/moat/modules/inv2/utils/items_stat.lua'] = true,
	['plugins/moat/modules/inv2/utils/items_talent.lua'] = true,
	['plugins/moat/modules/inv2/utils/text_effects.lua'] = true,
	['plugins/moat/modules/inv2/utils/weapons.lua'] = true,
	['plugins/moat/modules/inv2/utils/sql/ignore.lua'] = true,
	['plugins/moat/modules/inv2/shared/sh_anims.lua'] = true,
	['plugins/moat/modules/inv2/shared/sh_invs.lua'] = true,
	['plugins/moat/modules/inv2/shared/sh_items.lua'] = true,
	['plugins/moat/modules/inv2/shared/sh_omegas.lua'] = true,
	['plugins/moat/modules/inv2/shared/sh_mods.lua'] = true,
	['plugins/moat/modules/inv2/shared/sh_taunts.lua'] = true,
	['plugins/moat/modules/inv2/shared/sh_usables.lua'] = true,
	['plugins/moat/modules/inv2/shared/sh_talents.lua'] = true,
	['plugins/moat/modules/inv2/ass/very_old_rarities.lua'] = true,
	['plugins/moat/modules/inv2/ass/paints/sh_testskin.lua'] = true,
	['plugins/moat/modules/inv2/data/collect_dev.lua'] = true,
	['plugins/moat/modules/inv2/data/enums.lua'] = true,
	['plugins/moat/modules/inv2/data/rarities.lua'] = true,
	['plugins/moat/modules/inv2/data/stats.lua'] = true,
	['plugins/moat/modules/inv2/data/talents.lua'] = true,
	['plugins/moat/modules/inv2/data/weapons.lua'] = true,
	['plugins/moat/modules/raffles/sh_raffles.lua'] = true,
	['plugins/moat/modules/resources/mats.lua'] = true,
	['plugins/moat/modules/rounds/minigames/sh_damage.lua'] = true,
	['plugins/moat/modules/snap/init.lua'] = true,
	['plugins/moat/modules/snap/utils.lua'] = true,
	['plugins/moat/modules/tracers/sh_init.lua'] = true,
	['plugins/moat/modules/weapons/sh_vm.lua'] = true,
	['plugins/mse/init.lua'] = true,
	['plugins/mse/shared/sh_cmds.lua'] = true,
	['plugins/mse/util.lua'] = true,
	['plugins/weapons/terrortown/sh_biohazardball_config.lua'] = true,
	['plugins/weapons/terrortown/sh_rsb_config.lua'] = true,
	['plugins/weapons/vapes/sh_vapeswep.lua'] = true
}

local lua = {}
for _, path in ipairs(sv) do
	if (SERVER and not lua[path]) then
		include(path)
		lua[path] = true
	end
end

for _, path in ipairs(cl) do
	if (SERVER) then
		AddCSLuaFile(path)
	end

	if (sh[path] and not lua[path]) then
		include(path)
		lua[path] = true
	elseif (not lua[path] and CLIENT) then
		include(path)
		lua[path] = true
	end
end

hook.Run 'moat'

------------------------------------
--
-- Looks lame but fuck u i like it
--	
------------------------------------