//
//  YHDispatch_group.h
//  MyProject
//
//  Created by 吕颜辉 on 2019/12/28.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHDispatch_group : NSObject

/*
 * Copyright (c) 2008-2013 Apple Inc. All rights reserved.
 *
 * @APPLE_APACHE_LICENSE_HEADER_START@
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @APPLE_APACHE_LICENSE_HEADER_END@
 */

#ifndef __DISPATCH_GROUP__
#define __DISPATCH_GROUP__

#ifndef __DISPATCH_INDIRECT__
#error "Please #include <dispatch/dispatch.h> instead of this file directly."
#include <dispatch/base.h> // for HeaderDoc
#endif

DISPATCH_ASSUME_NONNULL_BEGIN

/*!
 * @typedef dispatch_group_t
 * @abstract
 * A group of blocks submitted to queues for asynchronous invocation.
 */
DISPATCH_DECL(dispatch_group);

__BEGIN_DECLS

/*!
 * @function dispatch_group_create
 *
 * @abstract
 * Creates new group with which blocks may be associated.
 *
 * @discussion
 * This function creates a new group with which blocks may be associated.
 * The dispatch group may be used to wait for the completion of the blocks it
 * references. The group object memory is freed with dispatch_release().
 *
 * @result
 * The newly created group, or NULL on failure.
 */
API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_MALLOC DISPATCH_RETURNS_RETAINED DISPATCH_WARN_RESULT
DISPATCH_NOTHROW
dispatch_group_t
dispatch_group_create(void);  //创建一个任务组

/*!
 * @function dispatch_group_async
 *
 * @abstract
 * Submits a block to a dispatch queue and associates the block with the given
 * dispatch group.
 *
 * @discussion
 * Submits a block to a dispatch queue and associates the block with the given
 * dispatch group. The dispatch group may be used to wait for the completion
 * of the blocks it references.
 *
 * @param group
 * A dispatch group to associate with the submitted block.
 *  与提交的block关联的调度组,这个调度组由 dispatch_group_create 生成,之后可以通过dispatch_group_wait或者dispatch_group_notify监听任务组内任务的执行情况
 *  eg:  dispatch_group_t group = dispatch_group_create();
 *
 * The result of passing NULL in this parameter is undefined.
 * 在此参数中传递NULL的结果是不确定的。
 *
 * @param queue
 * The dispatch queue to which the block will be submitted for asynchronous
 * invocation.
 * block将提交到该调度队列以进行异步调用。也就是 block执行线程任务的队列，任务组内不同任务的队列可以不同
 * eg:  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 *
 * @param block
 * The block to perform asynchronously.   该block异步执行。执行任务的block
 *
 * 把异步任务提交到指定任务组和指定下并拿出队列执行
 */
#ifdef __BLOCKS__
API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_NONNULL_ALL DISPATCH_NOTHROW
void
dispatch_group_async(dispatch_group_t group,
    dispatch_queue_t queue,
    dispatch_block_t block);
#endif /* __BLOCKS__ */

/*!
 * @function dispatch_group_async_f
 *
 * @abstract
 * Submits a function to a dispatch queue and associates the block with the
 * given dispatch group.
 *
 * @discussion
 * See dispatch_group_async() for details.
 *
 * @param group
 * A dispatch group to associate with the submitted function.
 * The result of passing NULL in this parameter is undefined.
 *
 * @param queue
 * The dispatch queue to which the function will be submitted for asynchronous
 * invocation.
 *
 * @param context
 * The application-defined context parameter to pass to the function.
 *
 * @param work
 * The application-defined function to invoke on the target queue. The first
 * parameter passed to this function is the context provided to
 * dispatch_group_async_f().
 */
API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_NONNULL1 DISPATCH_NONNULL2 DISPATCH_NONNULL4
DISPATCH_NOTHROW
void
dispatch_group_async_f(dispatch_group_t group,
    dispatch_queue_t queue,
    void *_Nullable context,
    dispatch_function_t work);

/*!
 * @function dispatch_group_wait
 *
 * @abstract
 * Wait synchronously until all the blocks associated with a group have
 * completed or until the specified timeout has elapsed.
 * 同步等待，直到与一个组关联的所有块都已完成，或者直到指定的超时时间过去为止。
 *
 * @discussion
 * This function waits for the completion of the blocks associated with the
 * given dispatch group, and returns after all blocks have completed or when
 * the specified timeout has elapsed.
 *  该函数等待与给定调度组关联的block的完成，并在所有块完成或指定的超时时间结束后返回。
 *
 * This function will return immediately if there are no blocks associated
 * with the dispatch group (i.e. the group is empty).
 * 如果没有与调度组关联的block（即该组为空），则此函数将立即返回
 *
 * The result of calling this function from multiple threads simultaneously
 * with the same dispatch group is undefined.
 * 从多个线程同时使用同一调度组调用此函数的结果是不确定的。
 *
 * After the successful return of this function, the dispatch group is empty.
 * It may either be released with dispatch_release() or re-used for additional
 * blocks. See dispatch_group_async() for more information.
 * 成功返回此函数后，调度组为空。可以使用dispatch_release（）释放它，也可以将其重新用于其他块。
 * 有关更多信息，请参见dispatch_group_async（）。
 *
 * @param group
 * The dispatch group to wait on.
 * The result of passing NULL in this parameter is undefined.
 *
 * @param timeout
 * When to timeout (see dispatch_time). As a convenience, there are the
 * DISPATCH_TIME_NOW and DISPATCH_TIME_FOREVER constants.
 * 何时超时（请参阅dispatch_time）。为方便起见，有DISPATCH_TIME_NOW和DISPATCH_TIME_FOREVER常量。
 * eg： dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC));
 *
 * 等待的超时时间（即等多久），单位为dispatch_time_t。如果设置为DISPATCH_TIME_FOREVER,则会一直等待（阻塞当前线程），直到任务组执行完毕
 *
 * @result
 * Returns zero on success (all blocks associated with the group completed
 * within the specified timeout) or non-zero on error (i.e. timed out).
 *
 * 等待组任务完成，会阻塞当前线程，当任务组执行完毕时，才会解除阻塞当前线程
 */
API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_NONNULL_ALL DISPATCH_NOTHROW
long
dispatch_group_wait(dispatch_group_t group, dispatch_time_t timeout);

/*!
 * @function dispatch_group_notify
 *
 * @abstract
 * Schedule a block to be submitted to a queue when all the blocks associated
 * with a group have completed.
 * 与一个组关联的所有block均已完成后，计划将一个lblock提交给队列。
 *
 * @discussion
 * This function schedules a notification block to be submitted to the specified
 * queue once all blocks associated with the dispatch group have completed.
 * 一旦与调度组关联的所有块均已完成，此函数将计划将通知块提交给指定的队列。
 *
 * If no blocks are associated with the dispatch group (i.e. the group is empty)
 * then the notification block will be submitted immediately.
 * 如果没有块与调度组相关联（即该组为空），则通知块将立即提交。
 *
 * The group will be empty at the time the notification block is submitted to
 * the target queue. The group may either be released with dispatch_release()
 * or reused for additional operations.
 * See dispatch_group_async() for more information.
 * 通知block提交到目标队列时，该组将为空。该组可以通过dispatch_release（）释放，也可以重新用于其他操作。
 * 有关更多信息，请参见dispatch_group_async（）。
 *
 * @param group
 * The dispatch group to observe.  需要监听的任务组
 * The result of passing NULL in this parameter is undefined.
 *
 * @param queue
 * The queue to which the supplied block will be submitted when the group
 * completes.  组完成后，将向其提交所提供的block的队列。
 * block任务执行的线程队列，和之前group执行的线程队列无关
 *
 * @param block
 * The block to submit when the group completes.
 * 待任务组执行完毕时调用，不会阻塞当前线程
 */
#ifdef __BLOCKS__
API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_NONNULL_ALL DISPATCH_NOTHROW
void
dispatch_group_notify(dispatch_group_t group,
    dispatch_queue_t queue,
    dispatch_block_t block);
#endif /* __BLOCKS__ */

/*!
 * @function dispatch_group_notify_f
 *
 * @abstract
 * Schedule a function to be submitted to a queue when all the blocks
 * associated with a group have completed.
 *
 * @discussion
 * See dispatch_group_notify() for details.
 *
 * @param group
 * The dispatch group to observe.
 * The result of passing NULL in this parameter is undefined.
 *
 * @param context
 * The application-defined context parameter to pass to the function.
 *
 * @param work
 * The application-defined function to invoke on the target queue. The first
 * parameter passed to this function is the context provided to
 * dispatch_group_notify_f().
 */
API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_NONNULL1 DISPATCH_NONNULL2 DISPATCH_NONNULL4
DISPATCH_NOTHROW
void
dispatch_group_notify_f(dispatch_group_t group,
    dispatch_queue_t queue,
    void *_Nullable context,
    dispatch_function_t work);

/*!
 * @function dispatch_group_enter
 *
 * @abstract
 * Manually indicate a block has entered the group  手动指示一个block进入了组
 *
 * @discussion
 * Calling this function indicates another block has joined the group through
 * a means other than dispatch_group_async(). Calls to this function must be
 * balanced with dispatch_group_leave().
 * 调用此函数表示另一个block已通过dispatch_group_async（）以外的其他方式加入了该组。
 * 对该函数的调用必须与dispatch_group_leave（）平衡。
 *
 * @param group
 * The dispatch group to update.
 * The result of passing NULL in this parameter is undefined.
 *
 * 用于添加对应任务组中的未执行完毕的任务数，执行一次，未执行完毕的任务数加1，当未执行完毕任务数为0的时候，
 * 才会使dispatch_group_wait解除阻塞和dispatch_group_notify的block执行
 */
API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_NONNULL_ALL DISPATCH_NOTHROW
void
dispatch_group_enter(dispatch_group_t group);

/*!
 * @function dispatch_group_leave
 *
 * @abstract
 * Manually indicate a block in the group has completed  手动指示组中的某个block已完成
 *
 * @discussion
 * Calling this function indicates block has completed and left the dispatch
 * group by a means other than dispatch_group_async().
 *
 * 调用此函数表示block已完成，并且已通过dispatch_group_async（）以外的其他方式离开了调度组
 *
 * @param group
 * The dispatch group to update.
 * The result of passing NULL in this parameter is undefined.
 *
 * 用于减少任务组中的未执行完毕的任务数，执行一次，未执行完毕的任务数减1，dispatch_group_enter和dispatch_group_leave要匹配，
 * 不然系统会认为group任务没有执行完毕

 */
API_AVAILABLE(macos(10.6), ios(4.0))
DISPATCH_EXPORT DISPATCH_NONNULL_ALL DISPATCH_NOTHROW
void
dispatch_group_leave(dispatch_group_t group);

__END_DECLS

DISPATCH_ASSUME_NONNULL_END


#endif

@end

NS_ASSUME_NONNULL_END
