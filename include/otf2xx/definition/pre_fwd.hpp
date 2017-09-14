/*
 * This file is part of otf2xx (https://github.com/tud-zih-energy/otf2xx)
 * otf2xx - A wrapper for the Open Trace Format 2 library
 *
 * Copyright (c) 2013-2016, Technische Universität Dresden, Germany
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 *
 * * Neither the name of the copyright holder nor the names of its
 *   contributors may be used to endorse or promote products derived from
 *   this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

#ifndef INCLUDE_OTF2XX_DEFINITION_PRE_FWD_HPP
#define INCLUDE_OTF2XX_DEFINITION_PRE_FWD_HPP

#include <otf2xx/common.hpp>

namespace otf2
{
namespace definition
{

    namespace detail
    {
        class group_base;

        template <typename Impl>
        class impl_base;

        class location_impl;
        class location_group_impl;
        class system_tree_node_impl;

        template <typename T, otf2::common::group_type GroupType>
        class group_impl;

        class comm_impl;
        class region_impl;
        class attribute_impl;
        class parameter_impl;
        class string_impl;
        class clock_properties_impl;

        class source_code_location_impl;
        class calling_context_impl;
        class interrupt_generator_impl;

        class io_file_impl;
        class io_directory_impl;
        class io_handle_impl;
        class io_paradigm_impl;
        class io_pre_created_handle_state_impl;

        class mapping_table_impl;

        class metric_base;
        class metric_class_impl;
        class metric_instance_impl;
        class metric_member_impl;

        template <typename Definition>
        class property_impl;

        class marker_impl;

        template <typename Definition>
        class weak_ref;
    }

    class location;
    class location_group;
    class system_tree_node;

    template <typename T, otf2::common::group_type GroupType>
    class group;

    class comm;
    class region;
    class attribute;
    class parameter;
    class string;
    class clock_properties;

    class source_code_location;
    class calling_context;
    class interrupt_generator;

    class io_file;
    class io_regular_file;
    class io_directory;
    class io_handle;
    class io_paradigm;
    class io_pre_created_handle_state;

    class mapping_table;

    class unknown;

    using locations_group = group<otf2::definition::location, otf2::common::group_type::locations>;
    using regions_group = group<otf2::definition::region, otf2::common::group_type::regions>;

    using comm_locations_group =
        group<otf2::definition::location, otf2::common::group_type::comm_locations>;
    using comm_group = group<otf2::definition::location, otf2::common::group_type::comm_group>;
    using comm_self_group = group<otf2::definition::location, otf2::common::group_type::comm_self>;

    class metric_member;
    class metric_class;
    class metric_instance;

    // TODO: which class of metric foo?
    // using metric_group = group<otf2::definition::metric,
    // otf2::common::group_type::metric>;

    template <typename Definition>
    class container;

    template <typename Definition>
    class property;

    using location_property = property<location>;
    using location_group_property = property<location_group>;
    using system_tree_node_property = property<system_tree_node>;
    using calling_context_property = property<calling_context>;
    using io_file_property = property<io_regular_file>;

    class marker;

    template <typename Definition>
    detail::weak_ref<Definition> make_weak_ref(const Definition&);
}
} // namespace otf2::definition

#endif // INCLUDE_OTF2XX_DEFINITION_PRE_FWD_HPP
