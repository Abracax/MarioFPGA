	lab8_soc u0 (
		.clk_clk                (<connected-to-clk_clk>),                //             clk.clk
		.keycode_export         (<connected-to-keycode_export>),         //         keycode.export
		.mario_alive_export     (<connected-to-mario_alive_export>),     //     mario_alive.export
		.mario_state_export     (<connected-to-mario_state_export>),     //     mario_state.export
		.mario_x_export         (<connected-to-mario_x_export>),         //         mario_x.export
		.mario_y_export         (<connected-to-mario_y_export>),         //         mario_y.export
		.mush_alive_export      (<connected-to-mush_alive_export>),      //      mush_alive.export
		.mush_x_export          (<connected-to-mush_x_export>),          //          mush_x.export
		.mush_y_export          (<connected-to-mush_y_export>),          //          mush_y.export
		.otg_hpi_address_export (<connected-to-otg_hpi_address_export>), // otg_hpi_address.export
		.otg_hpi_cs_export      (<connected-to-otg_hpi_cs_export>),      //      otg_hpi_cs.export
		.otg_hpi_data_in_port   (<connected-to-otg_hpi_data_in_port>),   //    otg_hpi_data.in_port
		.otg_hpi_data_out_port  (<connected-to-otg_hpi_data_out_port>),  //                .out_port
		.otg_hpi_r_export       (<connected-to-otg_hpi_r_export>),       //       otg_hpi_r.export
		.otg_hpi_reset_export   (<connected-to-otg_hpi_reset_export>),   //   otg_hpi_reset.export
		.otg_hpi_w_export       (<connected-to-otg_hpi_w_export>),       //       otg_hpi_w.export
		.reset_reset_n          (<connected-to-reset_reset_n>),          //           reset.reset_n
		.screen_offset_export   (<connected-to-screen_offset_export>),   //   screen_offset.export
		.sdram_clk_clk          (<connected-to-sdram_clk_clk>),          //       sdram_clk.clk
		.sdram_wire_addr        (<connected-to-sdram_wire_addr>),        //      sdram_wire.addr
		.sdram_wire_ba          (<connected-to-sdram_wire_ba>),          //                .ba
		.sdram_wire_cas_n       (<connected-to-sdram_wire_cas_n>),       //                .cas_n
		.sdram_wire_cke         (<connected-to-sdram_wire_cke>),         //                .cke
		.sdram_wire_cs_n        (<connected-to-sdram_wire_cs_n>),        //                .cs_n
		.sdram_wire_dq          (<connected-to-sdram_wire_dq>),          //                .dq
		.sdram_wire_dqm         (<connected-to-sdram_wire_dqm>),         //                .dqm
		.sdram_wire_ras_n       (<connected-to-sdram_wire_ras_n>),       //                .ras_n
		.sdram_wire_we_n        (<connected-to-sdram_wire_we_n>)         //                .we_n
	);

